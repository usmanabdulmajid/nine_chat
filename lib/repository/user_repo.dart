import 'package:nine_chat/models/user.dart';

class UserRepo {
  UserRepo._private();
  static final UserRepo _instance = UserRepo._private();
  static UserRepo get instance => _instance;
  late User user;
}
