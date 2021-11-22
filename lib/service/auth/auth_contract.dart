abstract class IAuth {
  Future<bool> signUp(String email, String password);
  Future<bool> signOut();
  Future<bool> logIn(String email, String password);
}
