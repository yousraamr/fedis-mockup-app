import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../repository/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository repository;
  LogoutUseCase(this.repository);

  Future<Either<Failure, void>> execute() {
    return repository.logout();
  }
}