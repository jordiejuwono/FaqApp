class NoDataResponse {
  int code;
  String message;
  dynamic data;

  NoDataResponse({
    required this.code,
    required this.message,
    this.data,
  });

  factory NoDataResponse.fromJson(Map<String, dynamic> json) => NoDataResponse(
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
