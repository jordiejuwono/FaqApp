import 'dart:convert';

LoginRequest loginRequestFromJson(String str) =>
    LoginRequest.fromJson(json.decode(str));

String loginRequestToJson(LoginRequest data) => json.encode(data.toJson());

class LoginRequest {
  String nip;
  String password;

  LoginRequest({
    required this.nip,
    required this.password,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
        nip: json["nip"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "nip": nip,
        "password": password,
      };
}
