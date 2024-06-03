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
  Set<int> selectedIndices = {};

  @override
  void initState() {
    super.initState();
    _fetchNotes();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _fetchNotes();
    });
  }

  void _fetchNotes() async {
    List<Map<String, dynamic>> userlist = await Databasehelper.getData();
    setState(() {
      allNotes = userlist;
    });
  }

  void deleteNote(int id) async {
    int result = await Databasehelper.deleteNoteById(id);
    if (result > 0) {
      print("Note with ID $id deleted successfully.");
    } else {
      print("Note with ID $id not found.");
    }
  }


  void _handleNoteItemTap(int index) {
    if (selectedIndices.isEmpty) {
      // Navigate to another page if no item is selected
      developer.log("Note $index tapped", name: 'listOfWritings');
      Navigator.pushNamed(
        context,
        '/editWriting',
        arguments: {'id': allNotes[index]['id']},
      );
    } else {
      // Toggle selection if some items are already selected
      setState(() {
        if (selectedIndices.contains(index)) {
          selectedIndices.remove(index);
        } else {
          selectedIndices.add(index);
        }
      });
      developer.log("Note $index ${selectedIndices.contains(index) ? 'selected' : 'deselected'}", name: 'listOfWritings');
    }
  }

  void _handleNoteItemLongPress(int index) {
    setState(() {
      if (selectedIndices.contains(index)) {
        selectedIndices.remove(index);
      } else {
        selectedIndices.add(index);
      }
    });
    developer.log("Note $index long pressed and ${selectedIndices.contains(index) ? 'selected' : 'deselected'}", name: 'listOfWritings');
  }

  /**
   * Delete all the selected notes
   */
  void deleteNotes(){
    var note = Note;
    selectedIndices.forEach((element) {
      deleteNote(allNotes[element]['id']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of your Writings'),
        automaticallyImplyLeading: false,
        actions: [
          if (selectedIndices.isNotEmpty)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Handle deletion of selected items
                developer.log("Delete selected items", name: 'listOfWritings');
                print(selectedIndices);
                deleteNotes();
              },
            ),
        ],
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
          bool isSelected = selectedIndices.contains(index);
          return GestureDetector(
            onTap: () => _handleNoteItemTap(index),
            onLongPress: () => _handleNoteItemLongPress(index),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.transparent,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: NoteItem(
                title: allNotes[index]['title'],
                description: allNotes[index]['description'],
                onTap: () => _handleNoteItemTap(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
