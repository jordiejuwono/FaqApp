import 'package:dio/dio.dart';
import 'package:faq_app/common/constants.dart';
import 'package:faq_app/common/failure_response.dart';
import 'package:faq_app/data/model/request/login_request.dart';
import 'package:faq_app/data/model/response/login_response.dart';

abstract class RemoteDataSource {
  Future<LoginResponse> loginUser({required LoginRequest request});
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
    } catch (error) {
      throw ServerFailure(error.toString());
    }
  }
}
