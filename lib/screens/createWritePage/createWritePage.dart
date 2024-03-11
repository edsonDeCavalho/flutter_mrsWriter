
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:hive/hive.dart';
import 'package:mrswriter/core/data/Note.dart';
import 'package:mrswriter/core/db/Databasehelper.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../../core/process/HiveProcess.dart';

final QuillController __controller = QuillController.basic();
var actualNote = null;


class CreateWritePage extends StatelessWidget {
  final titlecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a writing'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
                saveWritingInDataBase();
              _saveDocument(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: titlecontroller,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Title',
                ),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: QuillEditor.basic(
                  configurations: QuillEditorConfigurations(
                    controller: __controller,
                    readOnly: false,
                    placeholder: 'They are three criminals flight to Los Angels...',
                    sharedConfigurations: const QuillSharedConfigurations(
                      locale: Locale('fr'),
                    ),
                  ),
                ),
              ),
            ),
            QuillToolbar(
              configurations: const QuillToolbarConfigurations(),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.width_normal,
                      ),
                      onPressed: () {},
                    ),
                    QuillToolbarHistoryButton(
                      isUndo: true,
                      controller: __controller,
                    ),
                    QuillToolbarHistoryButton(
                      isUndo: false,
                      controller: __controller,
                    ),
                    QuillToolbarToggleStyleButton(
                      options: const QuillToolbarToggleStyleButtonOptions(),
                      controller: __controller,
                      attribute: Attribute.bold,
                    ),
                    // Other toolbar buttons...

                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<void> _saveDocument(BuildContext context) async {
    try {
      final String jsonData = documentToJson();
      final Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
      final String filePath = '${appDocumentsDirectory.path}/quill_document.json';
      final File file = File(filePath);
      await file.writeAsString(jsonData);
      print('Document saved successfully at: $filePath');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Document saved successfully'),
        ),
      );
    } catch (e) {
      print('Error saving document: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to save document'),
        ),
      );
    }
  }
  Future<void> saveWritingInDataBase() async {
    // var notesWritebox = Hive.box("notesWritebox");
    // var noteWrite = Note(gelastId(notesWritebox)+1, titlecontroller.text, getFirstWords(__controller), "");
    // notesWritebox.put(gelastId(notesWritebox), noteWrite);
    // print(notesWritebox.getAt(gelastId(notesWritebox)-1));


    int insertId = await Databasehelper.insertNote(titlecontroller.text, "test", "jsonFilename");
    print(insertId);

  }
  void getWritingOfDataBase(){

  }

  String getFirstWords(QuillController controller){
  // To get the text from the Quill editor
    String text = controller.document.toPlainText();
  // To split the text into words
    List<String> words = text.split(' ');
  // To get the first 15 words
    List<String> first15Words = words.take(15).toList();
  // To join the first 15 words back into a single string
    String first15WordsString = first15Words.join(' ');
    return first15WordsString;
  }

  String documentToJson() {
    final json = jsonEncode(__controller.document.toDelta().toJson());
    return json;
  }
}
