import 'package:nine_chat/models/chat.dart';
import 'package:nine_chat/models/message.dart';

abstract class ILocalDb {
  Future<bool> deleteMessages(List<String> messageId);
  Future<List<Message>> fetchMessages(String chatId);
  Future<bool> insertMessage(Message message);
  Future<bool> insertMessages(List<Message> messages);
  Future<bool> updateMessage(Message message);

  Future<List<Chat>> searchChats(String chatName);
  Future<bool> insertChats(List<Chat> chats);
  Future<bool> deleteChats(List<String> chatId);
  Future<List<Chat>> fetchChats();
}
