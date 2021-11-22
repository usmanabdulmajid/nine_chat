import 'package:nine_chat/models/user.dart';

abstract class IUserService {
  Future<User> createUser(User user);
  Future<List<User>> fetchUsers(String userId);
  Stream<User> user(String userId);
}
