class LogoutResponse {
  int code;
  String message;
  dynamic data;

  LogoutResponse({
    required this.code,
    required this.message,
    this.data,
  });

  factory LogoutResponse.fromJson(Map<String, dynamic> json) => LogoutResponse(
        code: json["code"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data,
      };
}
