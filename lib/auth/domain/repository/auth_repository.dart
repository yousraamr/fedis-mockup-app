import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, Map<String, dynamic>>> login(String email, String password);
  Future<Either<Failure, Map<String, dynamic>>> register(String name, String email, String password);
  Future<Either<Failure, void>> logout();
}
