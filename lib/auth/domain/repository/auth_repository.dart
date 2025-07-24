abstract class AuthRepository {
  Future<bool> login(String email, String password);
  Future<Map<String, dynamic>> register(String name, String email, String password);
}
