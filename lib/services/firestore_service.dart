import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note_model.dart';

class FirestoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Future<void> addNote(NoteModel note) async {
  //   await firestore.collection("notes").add({
  //     "title": note.title,
  //     "content": note.content,
  //     "color": note.color.value,
  //   });
  // }

  Future<void> addNote(NoteModel note) async {
    await firestore
        .collection("notes")
        .add(note.toMap());
  }
}