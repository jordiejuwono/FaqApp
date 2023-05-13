import 'package:dio/dio.dart';
import 'package:faq_app/common/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioHandler {
  late SharedPreferences sharedPreferences;

  DioHandler({
    required this.sharedPreferences,
  });

  Dio get dio => _getDio();

  Dio _getDio() {
    String bearerToken =
        sharedPreferences.getString(PreferenceKey.bearerToken) ?? "";

    BaseOptions options = BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );

    final dio = Dio(options);
    dio.options.headers["Authorization"] = "Bearer $bearerToken";

    return dio;
  }
}
