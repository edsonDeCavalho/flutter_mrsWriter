// Inside ListOfWritings.dart

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../components/NotesItem/NotesItem.dart';
import '../../core/data/Note.dart';
import '../../core/db/Databasehelper.dart';
import '../../core/process/HiveProcess.dart';
import 'dart:developer' as developer;


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
    WidgetsBinding.instance!.addPostFrameCallback((_) {
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

  void _handleNoteItemTap(int index) {
    developer.log("Note $index selected", name: 'listOfWritings');
    Navigator.pushNamed(context, '/createWriting', arguments: index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of your Writings'),
        automaticallyImplyLeading: false,
      ),
      body: // Inside ListOfWritings widget
      GridView.builder(
        itemCount: allNotes.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 1.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return NoteItem(
            title: allNotes[index]['title'],
            description: allNotes[index]['description'],
            onTap: () => _handleNoteItemTap(index), // Pass callback function
          );
        },
      ),

    );
  }
}
