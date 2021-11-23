import 'package:nine_chat/models/message.dart';
import 'package:nine_chat/service/message/message_service_contract.dart';
import 'package:supabase/supabase.dart';

class MessageService implements IMessageService {
  final SupabaseClient client;
  MessageService(this.client);
  late RealtimeSubscription realtimeSub;
  @override
  Stream<Message> messages(String userId) async* {
    realtimeSub = client
        .from('message')
        .on(SupabaseEventTypes.insert, (payload) {})
        .subscribe();
  }

  @override
  Future<List<Message>> retrieveOfflineMessages(String userId) async {
    final response =
        await client.from('message').select("*").eq("to", userId).execute();
    if (response.error != null) {}
    return [];
  }

  @override
  Future<bool> send(Message message) async {
    final response =
        await client.from('message').insert(message.toJson()).execute();
    if (response.error != null) {
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    client.removeSubscription(realtimeSub);
  }
}
