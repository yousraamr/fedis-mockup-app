import 'package:dartz/dartz.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/errors/failure.dart';
import '../../../core/storage/session_manager.dart';
import '../datasource/auth_datasourse.dart';
import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, Map<String, dynamic>>> login(String email, String password) async {
    try {
      final response = await remoteDataSource.login(email, password);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> register(String name, String email, String password) async {
    try {
      final response = await remoteDataSource.register(name, email, password);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await SessionManager.clearSession();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure("Failed to logout: ${e.toString()}"));
    }
  }
}
