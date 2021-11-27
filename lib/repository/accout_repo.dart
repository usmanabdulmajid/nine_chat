// ignore_for_file: unnecessary_null_comparison

import 'package:nine_chat/models/chat.dart';
import 'package:nine_chat/models/message.dart';
import 'package:nine_chat/models/user.dart';
import 'package:nine_chat/repository/user_repo.dart';
import 'package:nine_chat/service/auth/auth_contract.dart';
import 'package:nine_chat/service/cache/cache_contract.dart';
import 'package:nine_chat/service/chat/chat_service_contract.dart';
import 'package:nine_chat/service/local_db/local_db_contract.dart';
import 'package:nine_chat/service/message/message_service_contract.dart';
import 'package:nine_chat/service/user/user_service_contract.dart';
import 'package:supabase/supabase.dart' hide User;

abstract class IAccount {
  Future<bool> setupNewUserAccount(
      String email, String password, String username);
  Future<bool> setUpUserAccount();
  Future<bool> loginUserAccount(String email, String password);
  Future<void> fetchRecentChats(String userId);
  Future<bool> addNewChat(Chat chat);
  Future<bool> addNewMessage(Message message);
  Future<void> fetchRecentMessage(String userId);
}

class Account implements IAccount {
  final IAuth auth;
  final IUserService iUserService;
  final IChatService iChatService;
  final IMessageService iMessageService;
  final ILocalDb iLocalDb;
  final ICache iCache;
  final SupabaseClient client;
  Account(this.auth, this.iUserService, this.iCache, this.client,
      this.iChatService, this.iLocalDb, this.iMessageService);

  @override
  Future<bool> setupNewUserAccount(
      String email, String password, String username) async {
    final response = await auth.signUp(email, password);
    if (response == null) return false;
    var user = User(
      id: response.id,
      username: username,
      email: response.email,
      password: password,
      online: true,
    );
    var result = await iUserService.createUser(user);
    if (!result) return false;
    await iCache.saveBool('initial', true);
    await iCache.save(
        'session', client.auth.currentSession!.persistSessionString);
    await iCache.save('user', user.toString());
    await iChatService.createChats(user);
    return result;
  }

  @override
  Future<bool> setUpUserAccount() async {
    late final User user;
    final session = iCache.fetch('session');
    if (session == null) return false;
    final response = await client.auth.recoverSession(session);
    if (response.error != null) return false;
    await iCache.save('session', response.data!.persistSessionString);
    final data = iCache.fetch('user');
    if (data == null) {
      final authId = response.data!.user!.id;
      final result = await iUserService.fetchUser(authId);
      if (result == null) return false;
      user = result;
    } else {
      user = User.fromSource(data);
    }
    UserRepo.instance.user = user;
    fetchRecentChats(user.id!);
    fetchRecentMessage(user.id!);
    return true;
  }

  @override
  Future<bool> loginUserAccount(String email, String password) async {
    late final User user;
    final response = await auth.logIn(email, password);
    if (!response) return false;
    final authId = client.auth.currentUser!.id;
    await iCache.save(
        'session', client.auth.currentSession!.persistSessionString);
    final data = iCache.fetch('user');
    if (data == null) {
      final result = await iUserService.fetchUser(authId);
      if (result == null) return false;
      user = result;
    } else {
      user = User.fromSource(data);
    }
    UserRepo.instance.user = user;
    return true;
  }

  @override
  Future<void> fetchRecentChats(String userId) async {
    List<Chat> chats = await iChatService.fetchChats(userId);
    if (chats.isNotEmpty) {
      await iLocalDb.insertChats(chats);
    }
  }

  @override
  Future<bool> addNewChat(Chat chat) async {
    return await iLocalDb.insertChat(chat);
  }

  @override
  Future<bool> addNewMessage(Message message) async {
    return await iLocalDb.insertMessage(message);
  }

  @override
  Future<void> fetchRecentMessage(String userId) async {
    List<Message> messages = await iMessageService.retrieveMessages(userId);
    if (messages.isNotEmpty) {
      await iLocalDb.insertMessages(messages);
    }
  }
}
