class RegisterModel {
  final String token;
  final Map<String, dynamic> user;

  RegisterModel({required this.token, required this.user});

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      token: json['token'] ?? '',
      user: json['user'] ?? {},
    );
  }
}
