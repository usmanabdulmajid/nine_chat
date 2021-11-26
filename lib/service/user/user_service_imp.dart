import 'dart:async';

import 'package:nine_chat/models/user.dart';
import 'package:nine_chat/repository/user_repo.dart';
import 'package:nine_chat/service/user/user_service_contract.dart';
import 'package:supabase/supabase.dart' hide User;

class UserService implements IUserService {
  final SupabaseClient client;
  UserService(this.client);
  late RealtimeSubscription realtimeSub;
  final StreamController<User> _userStream = StreamController<User>.broadcast();

  @override
  Future<bool> createUser(User user) async {
    final response = await client.from('user').insert(user.toJson()).execute();
    if (response.error != null) {
      return false;
    }
    UserRepo.instance.user = user;
    return true;
  }

  @override
  Future<List<User>> fetchUsers(String userId) async {
    List<User> users = [];
    final response =
        await client.from('user').select("*").neq('user_id', userId).execute();
    if (response.error != null) {
      return <User>[];
    }
    users = (response.data as List).map((e) {
      return User.fromJson(e);
    }).toList();
    return users;
  }

  @override
  Stream<User> user(String userId) {
    realtimeSub = client.from('user').on(SupabaseEventTypes.insert, (payload) {
      final user = User.fromJson(payload.newRecord!);
      _userStream.sink.add(user);
    }).subscribe();
    return _userStream.stream;
  }

  @override
  void dispose() {
    _userStream.close();
    client.removeSubscription(realtimeSub);
  }

  @override
  Future<User?> fetchUser(String userId) async {
    final response =
        await client.from('users').select().eq('user_id', userId).execute();
    if (response.error != null) return null;
    return User.fromJson(response.data);
  }
}
