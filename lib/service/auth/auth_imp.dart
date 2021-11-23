import 'package:nine_chat/service/auth/auth_contract.dart';
import 'package:supabase/supabase.dart';

class Auth implements IAuth {
  final SupabaseClient client;
  Auth({required this.client});
  @override
  Future<bool> logIn(String email, String password) async {
    final response = await client.auth.signIn(email: email, password: password);
    if (response.error != null) {
      return false;
    }
    return true;
  }

  @override
  Future<bool> signOut() async {
    final response = await client.auth.signOut();
    if (response.error != null) {
      return false;
    }
    return true;
  }

  @override
  Future<User?> signUp(String email, String password) async {
    final response = await client.auth.signUp(email, password);
    if (response.error != null) {
      return null;
    }
    return response.data!.user;
  }
}
