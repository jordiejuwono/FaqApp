class LoginResponse {
  int code;
  String message;
  LoginData data;

  LoginResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        code: json["code"],
        message: json["message"],
        data: LoginData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data.toJson(),
      };
}

class LoginData {
  int id;
  String name;
  dynamic jenisUser;
  String email;
  String level;
  String pathFoto;
  String accessToken;
  String tokenType;
  String expiresIn;
  String nik;

  LoginData({
    required this.id,
    required this.name,
    this.jenisUser,
    required this.email,
    required this.level,
    required this.pathFoto,
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.nik,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        id: json["id"],
        name: json["name"],
        jenisUser: json["jenis_user"],
        email: json["email"],
        level: json["level"],
        pathFoto: json["path_foto"],
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
        nik: json["nik"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "jenis_user": jenisUser,
        "email": email,
        "level": level,
        "path_foto": pathFoto,
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
        "nik": nik,
      };
}
