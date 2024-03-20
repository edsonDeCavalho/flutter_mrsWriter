
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../core/data/Note.dart';
import '../../core/db/Databasehelper.dart';
import '../../core/process/HiveProcess.dart';


class ListOfWritings extends StatefulWidget {
  const ListOfWritings({Key? key}) : super(key: key);

  @override
  _ListOfWritingsState createState() => _ListOfWritingsState();
}
class _ListOfWritingsState extends State<ListOfWritings> {

  List<Map<String, dynamic>> allNotes = [];

  @override
  void initState() {
    super.initState();
    _fetchNotes();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchNotes();
    });
  }
  void _fetchNotes() async{
    List<Map<String, dynamic>> userlist = await Databasehelper.getData();
    setState(() {
      allNotes = userlist;
    });
  }


  @override
  void didPushNext() {
    _fetchNotes();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of your Writings'),
        automaticallyImplyLeading: false,
      ),
      body: GridView.builder(
        itemCount: allNotes.length,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      allNotes[index]['title'],
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      allNotes[index]['description'],
                      textAlign: TextAlign.start,
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



