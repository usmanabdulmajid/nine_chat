import 'dart:async';

import 'package:nine_chat/models/typing.dart';
import 'package:nine_chat/service/typing/typing_service_contract.dart';
import 'package:supabase/supabase.dart';

class TypingService implements ITypingService {
  final SupabaseClient client;
  final RealtimeClient realtimeClient;
  TypingService(this.client, this.realtimeClient);

  late RealtimeSubscription realTimeSub;
  final StreamController<Typing> _typingController =
      StreamController<Typing>.broadcast();

  @override
  void dispose() {
    realtimeClient.remove(realTimeSub);
    _typingController.close();
  }

  @override
  Future<bool> send(Typing typing) async {
    final response =
        await client.from('typing').insert(typing.toJson()).execute();
    if (response.error != null) return false;
    return true;
  }

  @override
  Stream<Typing> typings(String userId) {
    realTimeSub = realtimeClient.channel('realtime:public:typing:to=$userId');
    realTimeSub.on('INSERT', (payload, {ref}) {
      final typing = Typing.fromJson(payload['record']);
      _typingController.sink.add(typing);
    });
    return _typingController.stream;
  }
}
