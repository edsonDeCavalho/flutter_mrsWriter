import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:mrswriter/core/db/Databasehelper.dart';
import 'package:mrswriter/core/tools/String/StringTools.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../../core/process/HiveProcess.dart';

final QuillController __controller = QuillController.basic();
var actualNote = null;
var userId = "";
var noteId=0;
var filename="";

class CreateWritePage extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a writing'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveDocument(context, noteId);
              saveWritingInDataBase(noteId);
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
                    QuillToolbarToggleStyleButton(
                      options: const QuillToolbarToggleStyleButtonOptions(),
                      controller: __controller,
                      attribute: Attribute.italic,
                    ),
                    QuillToolbarToggleStyleButton(
                      controller: __controller,
                      attribute: Attribute.underline,
                    ),
                    QuillToolbarClearFormatButton(
                      controller: __controller,
                    ),
                    const VerticalDivider(),
                    QuillToolbarColorButton(
                      controller: __controller,
                      isBackground: false,
                    ),
                    QuillToolbarColorButton(
                      controller: __controller,
                      isBackground: true,
                    ),
                    const VerticalDivider(),

                    const VerticalDivider(),
                    QuillToolbarToggleCheckListButton(
                      controller: __controller,
                    ),
                    QuillToolbarToggleStyleButton(
                      controller: __controller,
                      attribute: Attribute.ol,
                    ),
                    QuillToolbarToggleStyleButton(
                      controller: __controller,
                      attribute: Attribute.ul,
                    ),
                    QuillToolbarToggleStyleButton(
                      controller: __controller,
                      attribute: Attribute.inlineCode,
                    ),
                    QuillToolbarToggleStyleButton(
                      controller: __controller,
                      attribute: Attribute.blockQuote,
                    ),
                    QuillToolbarIndentButton(
                      controller: __controller,
                      isIncrease: true,
                    ),
                    QuillToolbarIndentButton(
                      controller: __controller,
                      isIncrease: false,
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

  Future<void> _saveDocument(BuildContext context, int? noteId) async {
    try {
      final String jsonData = documentToJson();
      final Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
      DateTime now = DateTime.now();
      filename = "${getTitletoStore()}_${now.day}_${now.month}_${now.year}.json";
      final String filepath = appDocumentsDirectory.path + "/"+ filename;

      final File file = File(filepath);
      await file.writeAsString(jsonData);
      print('Document saved successfully at: $filepath');
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

  Future<void> saveWritingInDataBase(int? noteId) async {
    String text = __controller.document.toPlainText();
    noteId = await Databasehelper.insertNote(
        getTitletoStore(), StringTools.getFirstWords(text, 15), filename);
    print("Creation of a new Write with the id :$noteId");
  }

  String documentToJson() {
    final json = jsonEncode(__controller.document.toDelta().toJson());
    return json;
  }

  String getTitletoStore() {
    if (titleController.text.isEmpty) {
      return StringTools.removeSpaceAndRemplace(StringTools.getFirstWords(__controller.document.toPlainText(), 2));
    } else {
      return StringTools.removeSpaceAndRemplace(titleController.text);
    }
  }
}
