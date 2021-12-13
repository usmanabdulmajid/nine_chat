import 'dart:async';

import 'package:nine_chat/models/note.dart';
import 'package:nine_chat/service/note_status/note_contract.dart';
import 'package:supabase/supabase.dart';

class NoteStatus implements INoteStatus {
  final SupabaseClient client;
  final RealtimeClient realtimeClient;
  NoteStatus(this.client, this.realtimeClient);
  late RealtimeSubscription realtimeSub;
  final StreamController<Note> _noteController =
      StreamController<Note>.broadcast();

  @override
  Stream<Note> notes(String userId) {
    realtimeSub = realtimeClient.channel('realtime:public:note:to=$userId');
    realtimeSub.on('INSERT', (payload, {ref}) {
      final note = Note.fromJson(payload['record']);
      _noteController.sink.add(note);
    });
    return _noteController.stream;
  }

  @override
  Future<List<Note>> retrieveNotes(String userId) async {
    List<Note> notes = [];
    final response =
        await client.from('note').select('*').eq('userId', userId).execute();
    if (response.error != null) return notes;
    notes = (response.data as List).map((e) {
      return Note.fromJson(e);
    }).toList();
    return notes;
  }

  @override
  Future<bool> updateNoteStatus(Note note) async {
    final response = await client.from('note').insert(note.toJson()).execute();
    if (response.error != null) return false;
    return true;
  }

  @override
  void dispose() {
    _noteController.close();
    realtimeClient.remove(realtimeSub);
  }
}
