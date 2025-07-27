import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;
  LoginUseCase(this.repository);

  Future<Either<Failure, Map<String, dynamic>>> execute(String email, String password) {
    return repository.login(email, password);
  }
}