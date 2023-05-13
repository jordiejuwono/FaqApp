import 'package:dio/dio.dart';
import 'package:faq_app/common/constants.dart';
import 'package:faq_app/common/failure_response.dart';
import 'package:faq_app/data/model/request/login_request.dart';
import 'package:faq_app/data/model/request/post_faq_request.dart';
import 'package:faq_app/data/model/response/faq_list_response.dart';
import 'package:faq_app/data/model/response/login_response.dart';
import 'package:faq_app/data/model/response/logout_response.dart';
import 'package:faq_app/data/model/response/detail_faq_response.dart';

abstract class RemoteDataSource {
  // Auth
  Future<LoginResponse> loginUser({required LoginRequest request});
  Future<LogoutResponse> logoutUser();

  // Faq
  Future<FaqListResponse> fetchFaqList();
  Future<DetailFaqResponse> postFaq({required PostFaqRequest request});
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio dio;

  RemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<LoginResponse> loginUser({required LoginRequest request}) async {
    try {
      final formData = FormData.fromMap(request.toJson());
      final response =
          await dio.post('${AppConstants.baseUrl}auth/login', data: formData);
      return LoginResponse.fromJson(response.data);
    } on DioError catch (error) {
      throw ServerFailure(error.response?.data["message"]["error"] ??
          "Email / Password yang anda masukkan salah");
    }
  }

  @override
  Future<LogoutResponse> logoutUser() async {
    try {
      final response = await dio.post('${AppConstants.baseUrl}logout');
      return LogoutResponse.fromJson(response.data);
    } on DioError catch (error) {
      throw ServerFailure(error.toString());
    }
  }

  @override
  Future<FaqListResponse> fetchFaqList() async {
    try {
      final response =
          await dio.get('${AppConstants.baseUrl}superadmin/faq?page=1&rows=10');
      return FaqListResponse.fromJson(response.data);
    } on DioError catch (error) {
      throw ServerFailure(error.toString());
    }
  }

  @override
  Future<DetailFaqResponse> postFaq({required PostFaqRequest request}) async {
    try {
      final formData = FormData.fromMap(request.toJson());
      final response = await dio.post('${AppConstants.baseUrl}superadmin/faq',
          data: formData);
      return DetailFaqResponse.fromJson(response.data);
    } on DioError catch (error) {
      throw ServerFailure(
          error.response?.data["message"] ?? "Input FAQ baru gagal");
    }
  }
}
