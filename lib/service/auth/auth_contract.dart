import 'package:supabase/supabase.dart';

abstract class IAuth {
  Future<User?> signUp(String email, String password);
  Future<bool> signOut();
  Future<bool> logIn(String email, String password);
}
