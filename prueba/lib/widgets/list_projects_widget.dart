
import 'package:flutter/material.dart';

import '../models/models.dart';

class ListProjects extends StatelessWidget {
  const ListProjects({
    Key? key,
    required this.size,
    required this.projects,
  }) : super(key: key);

  final Size size;
  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: projects.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'projectDetailScreen', arguments: projects[index]);
            },
            child: SizedBox(
                height: 200,
                width: size.width,
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 2,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, bottom: 15, left: 40, right: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 100,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    projects[index].title,
                                    maxLines: 2,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    projects[index].subtitle,
                                    style: const TextStyle(
                                        fontSize: 10, color: Colors.grey),
                                  ),
                                ],
                              )),
                          SizedBox(
                              width: 130,
                              child: FadeInImage(
                                fit: BoxFit.cover,
                                width: 130,
                                
                                placeholder:
                                    const AssetImage('assets/loading.gif'),
                                image: NetworkImage(
                                    'https://www.linomackay.com/' +
                                        projects[index].imageUrl),
                              )),
                        ],
                      ),
                    ))),
          ),
        );
      },
    );
  }
}