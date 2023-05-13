class DetailFaqResponse {
  int code;
  String message;
  PostData data;

  DetailFaqResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory DetailFaqResponse.fromJson(Map<String, dynamic> json) =>
      DetailFaqResponse(
        code: json["code"],
        message: json["message"],
        data: PostData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data.toJson(),
      };
}

class PostData {
  String pertanyaan;
  String jawaban;
  bool statusPublish;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  PostData({
    required this.pertanyaan,
    required this.jawaban,
    required this.statusPublish,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory PostData.fromJson(Map<String, dynamic> json) => PostData(
        pertanyaan: json["pertanyaan"],
        jawaban: json["jawaban"],
        statusPublish: json["status_publish"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "pertanyaan": pertanyaan,
        "jawaban": jawaban,
        "status_publish": statusPublish,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
