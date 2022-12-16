import 'package:flutter/material.dart';

import '../models/models.dart';
import '../providers/providers.dart';


class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    final Project project =
        ModalRoute.of(context)!.settings.arguments as Project;
         final projectListProvider = Provider.of<ProjectListProvider>(context);

    

    void addNewProject() {
      projectListProvider.newProject(project);
    }
    
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          title: Text('Desarrollo'),
          actions: [
            IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Me gusta',
            onPressed: () {
              final uiProvider= Provider.of<UiProvider>(context, listen: false);
              uiProvider.selectedMenuOpt = 1;
              addNewProject();

             Navigator.pushReplacementNamed(context, 'navigationScreen');
            },)

          ],
        ),
        body: Column(
          children: [
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                  ),
                  Text(
                    project.title,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(project.subtitle,
                    style: TextStyle(fontSize: 15, color: Colors.grey),),

                  SizedBox(height: 25,),
                  Text('Descripción: '),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:20.0),
                    child: Text(project.description),
                  ),
                  
                  Container(
              height: 200,
              width: double.infinity,
              child: Image.network(
                  'https://www.linomackay.com/' + project.imageUrl),
            ),
                ],
              ),
            )
          ],
        ));
  }
}
