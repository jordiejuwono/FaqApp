class PostFaqRequest {
  String pertanyaan;
  String jawaban;
  bool statusPublish;

  PostFaqRequest({
    required this.pertanyaan,
    required this.jawaban,
    required this.statusPublish,
  });

  factory PostFaqRequest.fromJson(Map<String, dynamic> json) => PostFaqRequest(
        pertanyaan: json["pertanyaan"],
        jawaban: json["jawaban"],
        statusPublish: json["status_publish"],
      );

  Map<String, dynamic> toJson() => {
        "pertanyaan": pertanyaan,
        "jawaban": jawaban,
        "status_publish": statusPublish,
      };
}
