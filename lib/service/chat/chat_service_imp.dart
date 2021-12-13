import 'dart:async';

import 'package:nine_chat/models/chat.dart';
import 'package:nine_chat/models/user.dart';
import 'package:nine_chat/service/chat/chat_service_contract.dart';
import 'package:nine_chat/service/local_db/local_db_contract.dart';
import 'package:nine_chat/service/user/user_service_contract.dart';
import 'package:supabase/supabase.dart' hide User;
import 'package:uuid/uuid.dart';

class ChatService implements IChatService {
  final SupabaseClient client;
  final RealtimeClient realtimeClient;
  final IUserService iUserService;
  final ILocalDb iLocalDb;
  ChatService(
      this.client, this.realtimeClient, this.iUserService, this.iLocalDb);
  late RealtimeSubscription realtimeSub;
  final StreamController<Chat> _chatController =
      StreamController<Chat>.broadcast();

  @override
  Future<bool> createChats(User user) async {
    List<Chat> chats = [];
    final users = await iUserService.fetchUsers(user.id!);
    if (users.isEmpty) return false;
    chats = users.map((chat) {
      var uid = const Uuid().v4();
      return Chat(
        id: chat.id,
        chatName: chat.username,
        chatId: uid,
        imageUrl: chat.imageUrl,
      );
    }).toList();
    final userResponse = await client.from('chats').insert(chats.map((chat) {
      return {
        'id': chat.id,
        'userId': user.id,
        'chatId': chat.chatId,
        'chatName': chat.chatName,
        'imageUrl': chat.imageUrl,
      };
    })).execute();
    if (userResponse.error != null) {
      return false;
    }
    final chatsResponse = await client.from('chats').insert(chats.map((chat) {
      return {
        'id': chat.id,
        'userId': chat.chatId,
        'chatId': user.id,
        'chatName': user.username,
        'imageUrl': user.imageUrl,
      };
    })).execute();
    if (chatsResponse.error != null) {
      return false;
    }
    await iLocalDb.insertChats(chats);
    return true;
  }

  @override
  Future<List<Chat>> fetchChats(String userId) async {
    List<Chat> chats = [];
    final response =
        await client.from('chats').select("*").eq('userId', userId).execute();
    if (response.error != null) {
      return <Chat>[];
    }
    chats = (response.data as List).map((chat) {
      return Chat(
        id: chat['id'],
        chatId: chat['chatId'],
        chatName: chat['chatName'],
        imageUrl: chat['imageUrl'],
        lastmessage: chat['lastmessage'],
      );
    }).toList();
    return chats;
  }

  @override
  Stream<Chat> chat(String userId) {
    realtimeSub =
        realtimeClient.channel('realtime:public:chats:chatId=$userId');
    realtimeSub.on('INSERT', (payload, {ref}) {
      final chat = Chat.fromJson(payload['record']);
      _chatController.sink.add(chat);
    });

    return _chatController.stream;
  }

  @override
  Stream<Chat> updatedChat(String userId) {
    // TODO: implement updatedChat
    throw UnimplementedError();
  }

  @override
  void dispose() {
    _chatController.close();
    realtimeSub.unsubscribe();
  }
}
