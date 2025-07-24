import '../repository/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Map<String, dynamic>> execute(String name, String email, String password) async {
    return await repository.register(name, email, password);
  }
}