import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prueba/models/models.dart';
import 'package:http/http.dart' as http;



class ProjectService extends ChangeNotifier {
  final String _baseUrl = 'personalwebback-production-d2c3.up.railway.app';
  

  final List<Project> projects = [];
  bool isLoading = true;
  ProjectService() {
    loadProjects();
  }
  Future<List<Project>> loadProjects() async {
    isLoading = true;
    notifyListeners();
    
    final url = Uri.https(_baseUrl, 'projects');
   
    final resp = await http.get(url);
    print(resp.body);

    final List<dynamic> projectsMap = json.decode(resp.body);

    projectsMap.forEach((element) {
      final tempProject = Project.fromMap(element);
      projects.add(tempProject);
      
    },);

    // projectsMap.forEach((key, value) {
    //   final tempCategory = Project.fromMap(value);
    //   tempCategory.id = key;
    //   print(tempCategory.title);
    //   projects.add(tempCategory);
    // });
    print('el primero es:');
    print(projects[0]);

    // print('el tamanio de la lista es: ');
    // print(projects.length);



    isLoading = false;
    notifyListeners();
    return projects;
  }
}