import 'dart:async';

import 'package:nine_chat/service/message_status/message_status_contract.dart';
import 'package:nine_chat/utils/enums/message_status.dart';
import 'package:supabase/supabase.dart';

class MessageStatusService implements IMessageStatusService {
  final SupabaseClient client;
  final RealtimeClient realtimeClient;
  late RealtimeSubscription realtimeSub;
  final StreamController<MessageStatus> _statusController =
      StreamController<MessageStatus>.broadcast();
  MessageStatusService(this.client, this.realtimeClient);

  @override
  void dispose() {
    _statusController.close();
    realtimeClient.remove(realtimeSub);
  }

  @override
  Stream<MessageStatus> status(String userId) {
    realtimeSub =
        realtimeClient.channel('realtime:public:messageStatus:to=$userId');
    realtimeSub.on('INSERT', (payload, {ref}) {
      final messageStatus = ParseMessageStatus.fromString(payload['record']);
      _statusController.sink.add(messageStatus);
    });

    return _statusController.stream;
  }

  @override
  Future<bool> send(MessageStatus messageStatus) async {
    final response = await client
        .from('messageStatus')
        .insert(messageStatus.value())
        .execute();
    if (response.error != null) return false;
    return true;
  }

  @override
  Future<List<MessageStatus>> retrieveMessageStatus(String userId) async {
    List<MessageStatus> messageStatuses = [];
    final response = await client
        .from('messageStatus')
        .select('*')
        .eq('to', userId)
        .execute();
    if (response.error != null) return messageStatuses;
    messageStatuses = (response.data as List)
        .map((element) => ParseMessageStatus.fromString(element))
        .toList();
    return messageStatuses;
  }
}
