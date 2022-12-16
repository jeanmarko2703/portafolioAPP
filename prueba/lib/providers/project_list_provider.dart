import 'package:flutter/material.dart';
import 'package:prueba/providers/providers.dart';

import '../models/models.dart';

class ProjectListProvider extends ChangeNotifier {
  List<Project> projects = [];
 

  ProjectListProvider() {
    loadProjects();
    
  }

  
 

  newProject(Project project) async {
    
    bool search= await searchProjectById(project.id);

    if( !search ){
      DBProvider.db.newProject(project);
      
        projects.add(project);
       
      }
       notifyListeners();

    
    
  }
  Future<bool> searchProjectById(String id) async {
    final projectsLoaded = await DBProvider.db.projects();
    bool found=false;
    projectsLoaded.forEach((element) {
      if(element.id==id){
        found=true;
        print(element.title);
      }
      
    });

    print('el valor es:');
    print(found);

    return found;
    
    
  }

  loadProjects() async {
    
    final projectsLoaded = await DBProvider.db.projects();
    projects = List.from(projectsLoaded);

    notifyListeners();
  }

  deleteById(String id) async {
    await DBProvider.db.deleteProject(id);
    loadProjects();
  }

  


}
