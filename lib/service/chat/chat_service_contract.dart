import 'package:nine_chat/models/chat.dart';
import 'package:nine_chat/models/user.dart';

abstract class IChatService {
  Future<bool> createChats(User user);
  Future<List<Chat>> fetchChats(String userId);
  Stream<Chat> chat(String userId);
  Stream<Chat> updatedChat(String userId);
  void dispose();
}
