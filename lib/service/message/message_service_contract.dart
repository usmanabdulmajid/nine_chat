import 'package:nine_chat/models/message.dart';
import 'package:nine_chat/models/user.dart';

abstract class IMessageService {
  Future<bool> send(Message message);
  Stream<Message> messages(User user);
}
