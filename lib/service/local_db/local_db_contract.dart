import 'package:nine_chat/models/chat.dart';
import 'package:nine_chat/models/message.dart';

abstract class ILocalDb {
  Future<bool> deleteMessages(List<Message> messages);
  Future<List<Message>> fetchMessages(String userId);
  Future<bool> insertMessage(Message message);
  Future<bool> updateMessage(Message message);

  Future<List<Chat>> searchChats(String chatName);
  Future<bool> insertChats(List<Chat> chats);
  Future<bool> deleteChats(String chatId);
  Future<List<Chat>> fetchChats();
}
