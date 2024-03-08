
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:hive/hive.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

final QuillController __controller = QuillController.basic();




class CreateWritePage extends StatelessWidget {



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
              _saveDocument();
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
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Future<void> _saveDocument() async {
    try {
      final String jsonData = documentToJson();
      final Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
      final String filePath = '${appDocumentsDirectory.path}/quill_document.json';
      final File file = File(filePath);
      await file.writeAsString(jsonData);
      print('Document saved successfully at: $filePath');
      // ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      //   SnackBar(
      //     content: Text('Document saved successfully'),
      //   ),
      // );
    } catch (e) {
      print('Error saving document: $e');
      // ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      //   SnackBar(
      //     content: Text('Failed to save document'),
      //   ),
      // );
    }
  }
  void saveWritingInDataBase(){
    var localBox = Hive.box("localbox");
    localBox.put(0, 'Mith');
    print(localBox.getAt(0));
  }
  void getWritingOfDataBase(){

  }
  String documentToJson() {
    final json = jsonEncode(__controller.document.toDelta().toJson());
    return json;
  }
}
