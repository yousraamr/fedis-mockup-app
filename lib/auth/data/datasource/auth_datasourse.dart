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
        Logger.success("✅ Login successful");
        return response.data;
      } else {
        throw ServerException(message: "Login failed");
      }
    } on DioException catch (e) {
      final errorMessage = _extractErrorMessage(e.response?.data);
      Logger.error("❌ Login API Error: $errorMessage");
      throw ServerException(message: errorMessage);
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
        Logger.success("✅ Registration successful");
        return response.data;
      } else {
        throw ServerException(message: "Registration failed");
      }
    } on DioException catch (e) {
      final errorMessage = _extractErrorMessage(e.response?.data);
      Logger.error("❌ Register API Error: $errorMessage");
      throw ServerException(message: errorMessage);
    }
  }

  String _extractErrorMessage(dynamic data) {
    if (data == null) return "Unknown error occurred";
    if (data is String) return data; // API returned plain text
    if (data is Map<String, dynamic>) {
      if (data.containsKey('message')) return data['message'];
      if (data.containsKey('error')) return data['error'];
    }
    return "Something went wrong";
  }
}