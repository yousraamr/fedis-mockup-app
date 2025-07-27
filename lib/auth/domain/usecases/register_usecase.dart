import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../repository/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;
  RegisterUseCase(this.repository);

  Future<Either<Failure, Map<String, dynamic>>> execute(String name, String email, String password) {
    return repository.register(name, email, password);
  }
}