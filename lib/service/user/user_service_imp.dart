import 'package:nine_chat/models/user.dart';
import 'package:nine_chat/repository/user_repo.dart';
import 'package:nine_chat/service/user/user_service_contract.dart';
import 'package:supabase/supabase.dart' hide User;

class UserService implements IUserService {
  final SupabaseClient client;
  UserService(this.client);
  late RealtimeSubscription realtimeSub;
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
  Future<List<User>> fetchUsers(String userId) {
    // TODO: implement fetchUsers
    throw UnimplementedError();
  }

  @override
  Stream<User> user(String userId) {
    // TODO: implement user
    throw UnimplementedError();
  }

  @override
  void dispose() {
    client.removeSubscription(realtimeSub);
  }
}
