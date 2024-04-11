import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:mrswriter/core/db/Databasehelper.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../../core/process/HiveProcess.dart';

final QuillController __controller = QuillController.basic();
var actualNote = null;
var userId = "";

class CreateWritePage extends StatelessWidget {
  final TextEditingController titleController;
  final int? id;

  CreateWritePage({Key? key, this.id, required this.titleController})
      : super(key: key);

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
                controller: titleController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Title',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: QuillEditor.basic(
                  // Remove controller from here
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
      final Directory appDocumentsDirectory =
      await getApplicationDocumentsDirectory();
      DateTime now = DateTime.now();
      final String filePath = appDocumentsDirectory.path +
          "/" +
          titleController.text +
          "_" +
          now.day.toString() +
          "_" +
          now.month.toString() +
          "_" +
          now.year.toString() +
          ".json";
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
    DateTime now = DateTime.now();
    String fileName = titleController.text + now.toString() + ".json";
    if (id != null) {
      fileName = "$id-$fileName";
    }
    int insertId = await Databasehelper.insertNote(
        titleController.text, getFirstWords(__controller), fileName);
    print(insertId);
  }

  String getFirstWords(QuillController controller) {
    String text = controller.document.toPlainText();
    List<String> words = text.split(' ');
    List<String> first15Words = words.take(15).toList();
    String first15WordsString = first15Words.join(' ');
    return first15WordsString;
  }

  String documentToJson() {
    final json = jsonEncode(__controller.document.toDelta().toJson());
    return json;
  }
}
