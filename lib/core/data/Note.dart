import 'package:hive/hive.dart';

class Note {
  final int id;
  final String title;
  final String description;
  final String jsonFilename;


  const Note(this.id,this.title, this.description, this.jsonFilename);

  @override
  String toString() {
    return 'Note{id: $id, title: $title, description: $description, jsonFilename: $jsonFilename}';
  }

}

class NoteAdapter extends TypeAdapter<Note> {
  @override
  final int typeId = 0; // Unique ID for the Note class

  @override
  Note read(BinaryReader reader) {
    final id = reader.readInt();
    final title = reader.readString();
    final description = reader.readString();
    final jsonFilename = reader.readString();
    return Note(id, title, description, jsonFilename);
}

  @override
  void write(BinaryWriter writer, Note obj) {
    writer.writeInt(obj.id);
          writer.writeString(obj.title);
          writer.writeString(obj.description);
    writer.writeString(obj.jsonFilename);
  }
}