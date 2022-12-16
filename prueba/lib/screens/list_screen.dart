import 'package:flutter/material.dart';
import 'package:prueba/models/models.dart';


import '../providers/providers.dart';
import '../widgets/widgets.dart';

class ListScreen extends StatefulWidget {
   
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  String newHabit = '';
  List<Project> list = [];
  List<Project> _list = [];
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    final projectListProvider = Provider.of<ProjectListProvider>(context);
    if (list.isEmpty) {
      list = _list = projectListProvider.projects ;
    }
    
    return  Scaffold(
      body:SafeArea(child: _list.isEmpty?Center(child: Text('Añade un proyecto'),) :ListProjects(size: size, projects: _list)),
    );
  }
}