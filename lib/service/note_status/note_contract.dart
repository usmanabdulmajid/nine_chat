import 'package:nine_chat/models/note.dart';

abstract class INoteStatus {
  Future<bool> updateNoteStatus(Note note);
  Future<List<Note>> retrieveNotes(String userId);
  Stream<Note> notes(String userId);
  void dispose();
}
