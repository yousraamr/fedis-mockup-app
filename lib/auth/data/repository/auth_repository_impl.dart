import 'package:fedis_mockup_demo/auth/data/datasource/auth_datasourse.dart';
import 'package:fedis_mockup_demo/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    return await remoteDataSource.login(email, password);
  }

  @override
  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final response = await remoteDataSource.register(name, email, password);
    return response;
  }

}
