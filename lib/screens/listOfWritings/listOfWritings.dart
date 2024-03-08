
import 'package:flutter/material.dart';

import '../../core/data/Note.dart';

class ListOfWritings extends StatefulWidget {
  @override
  _MyGridPageState createState() => _MyGridPageState();
}

class _MyGridPageState extends State<ListOfWritings> {
  List<Note> items = [
    Note(1,'Item 1', 'Description 1',""),
    Note(2,'Item 2', 'Description 2',""),
    Note(3,'Item 3', 'Description 3',""),
    Note(4,'Item 4', 'Description 4',""),
    Note(5,'Item 5', 'Description 5', ""),
    Note(6,'Item 6', 'Description 6', ""),
    Note(7,'Item 7', 'Description 7', ""),
    Note(8,'Item 8', 'Description 8', ""),
    Note(9,'Item 9', 'Description 9', ""),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid List Example'),
      ),
      body: GridView.builder(
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 1.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: Card(
              color: Colors.lightBlueAccent,
              child: SizedBox(
                height: MediaQuery.of(context).size.height *
                    15,
                width: MediaQuery.of(context).size.width *
                    15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      items[index].title,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      items[index].description,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}