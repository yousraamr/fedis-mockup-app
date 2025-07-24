import 'package:dio/dio.dart';
import 'package:fedis_mockup_demo/utils/urls.dart';

class AuthDataSource {
  final Dio dio;

  AuthDataSource(this.dio);

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await dio.post('https://cartverse-data.onrender.com/login', data: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Login failed');
    }
  }


  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final response = await dio.post(ApiUrls.register, data: {
      "name": name,
      "email": email,
      "password": password,
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("✅ Registration Successful");
      print("Response Data: ${response.data}");

      // Extract token & user info
      final token = response.data['token'];
      final user = response.data['user'];

      print("Token: $token");
      print("User Details: $user");

      return response.data; // Return the whole data
    } else {
      print("❌ Registration Failed: ${response.statusCode}");
      throw Exception("Failed to register");
    }
  }

}
