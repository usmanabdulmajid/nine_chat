import 'dart:async';
import 'package:nine_chat/models/message.dart';
import 'package:nine_chat/service/message/message_service_contract.dart';
import 'package:supabase/supabase.dart';

class MessageService implements IMessageService {
  final SupabaseClient client;
  final RealtimeClient realtimeClient;
  MessageService(this.client, this.realtimeClient);
  late RealtimeSubscription realtimeSub;
  final StreamController<Message> _messageController =
      StreamController<Message>.broadcast();

  @override
  Stream<Message> messages(String userId) {
    realtimeSub = realtimeClient.channel('realtime:public:message:to=$userId');
    realtimeSub.on('INSERT', (payload, {ref}) {
      final message = Message.fromJson(payload['record']);
      _messageController.sink.add(message);
    });
    return _messageController.stream;
  }

  @override
  Future<List<Message>> retrieveMessages(String userId) async {
    List<Message> messages = [];
    final response =
        await client.from('message').select("*").eq("to", userId).execute();
    if (response.error != null) {
      return [];
    }
    messages = (response.data as List).map((message) {
      return Message.fromJson(message);
    }).toList();
    return messages;
  }

  @override
  Future<bool> send(Message message) async {
    if (message.editId != null) await _editMessage(message);

    final response =
        await client.from('message').insert(message.toJson()).execute();
    if (response.error != null) {
      return false;
    }
    return true;
  }

  Future<bool> _editMessage(Message message) async {
    final response =
        await client.from('message').update(message.toJson()).execute();
    if (response.error != null) {
      return false;
    }
    return true;
  }

  @override
  Future<bool> replyMessageIndex(Message message) async {
    if (message.editId != null) return await _editMessage(message);
    final response =
        await client.from('message').insert(message.toJson()).execute();
    if (response.error != null) return false;
    return true;
  }

  @override
  void dispose() {
    _messageController.close();
    realtimeSub.unsubscribe();
  }
}
