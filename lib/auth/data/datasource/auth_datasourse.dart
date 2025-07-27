import 'package:dio/dio.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/utils/logger.dart';
import '../../../core/utils/urls.dart';

class AuthDataSource {
  final Dio dio;

  AuthDataSource(this.dio);

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await dio.post(ApiUrls.login, data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        Logger.success("Login successful");
        return response.data;
      } else {
        throw ServerException(message: "Login failed");
      }
    } on DioException catch (e) {
      Logger.error("Login API Error: ${e.response?.data}");
      throw ServerException(message: e.response?.data['message'] ?? "Server Error");
    }
  }

  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    try {
      final response = await dio.post(ApiUrls.register, data: {
        "name": name,
        "email": email,
        "password": password,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        Logger.success("Registration successful");
        return response.data;
      } else {
        throw ServerException(message: "Registration failed");
      }
    } on DioException catch (e) {
      Logger.error("Register API Error: ${e.response?.data}");
      throw ServerException(message: e.response?.data['message'] ?? "Server Error");
    }
  }
}