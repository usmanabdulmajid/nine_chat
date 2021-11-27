import 'package:nine_chat/models/typing.dart';

abstract class ITypingService {
  Future<bool> send(Typing typing);
  Stream<Typing> typings(String userId);
  void dispose();
}
