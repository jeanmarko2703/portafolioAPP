import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prueba/providers/providers.dart';
import 'package:prueba/services/project_service.dart';
import 'package:prueba/theme/app_theme.dart';

import '../models/models.dart';
import '../widgets/list_projects_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Project> allProjects = [];
  List<Project> _projectsList = [];
  String query = '';
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timestamp) {
      final projectService =
          Provider.of<ProjectService>(context, listen: false);

      setState(() {
        allProjects = _projectsList = projectService.projects;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final projectService = Provider.of<ProjectService>(context);

    void search(value) {
      setState(() {
        value = value.toUpperCase();

        _projectsList = allProjects.where((project) {
          var projectName = project.title.toUpperCase();

          return projectName.contains(value);
        }).toList();
      });
    }

    void noSearch() {
      setState(() {
        _projectsList = allProjects;
      });
    }

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Stack(
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: size.height * 0.35, left: 10, right: 10),
            child: projectService.isLoading
                ? Center(child: CircularProgressIndicator())
                : ListProjects(size: size, projects: _projectsList),
          ),
          BackgroundHeader(
            height: size.height * 0.3,
          ),
          Header(size: size),
          Padding(
            padding:
                EdgeInsets.only(top: size.height * 0.28, left: 10, right: 10),
            child: SizedBox(
                height: 50,
                child: CupertinoSearchTextField(
                  placeholder: 'Buscar',
                  onChanged: (value) => {
                    if (value.isNotEmpty) {search(value)} else {noSearch()}
                  },
                  onSubmitted: null,
                  backgroundColor: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                )),
          )
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.only(top: size.height * 0.05, left: 10, right: 10),
      child: Column(
        children: const [
          Text(
            'Bienvenido al repositorio de proyectos',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Lino Mackay',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white30,
                fontSize: 25),
          ),
        ],
      ),
    ));
  }
}

class BackgroundHeader extends StatelessWidget {
  const BackgroundHeader({Key? key, required this.height}) : super(key: key);
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.primary,
      width: double.infinity,
      height: height,
    );
  }
}
