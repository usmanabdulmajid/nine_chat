import 'package:nine_chat/utils/enums/message_status.dart';

abstract class IMessageStatusService {
  Future<bool> send(MessageStatus messageStatus);
  Stream<MessageStatus> status(String userId);
  Future<List<MessageStatus>> retrieveMessageStatus(String userId);
  void dispose();
}
