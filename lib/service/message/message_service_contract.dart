import 'package:nine_chat/models/message.dart';

abstract class IMessageService {
  Future<bool> send(Message message);
  Stream<Message> messages(String userId);
  Future<List<Message>> retrieveMessages(String userId);
  void dispose();
}
