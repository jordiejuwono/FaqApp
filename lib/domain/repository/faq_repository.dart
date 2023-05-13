import 'package:dartz/dartz.dart';
import 'package:faq_app/common/failure_response.dart';
import 'package:faq_app/data/model/request/login_request.dart';
import 'package:faq_app/data/model/request/post_faq_request.dart';
import 'package:faq_app/data/model/response/faq_list_response.dart';
import 'package:faq_app/data/model/response/login_response.dart';
import 'package:faq_app/data/model/response/logout_response.dart';
import 'package:faq_app/data/model/response/detail_faq_response.dart';

abstract class FaqRepository {
  // local
  Future<Either<FailureResponse, bool>> saveBearerToken(String bearerToken);

  // remote
  Future<Either<FailureResponse, LoginResponse>> loginUser(
      {required LoginRequest request});
  Future<Either<FailureResponse, LogoutResponse>> logoutUser();
  Future<Either<FailureResponse, FaqListResponse>> fetchFaqList();
  Future<Either<FailureResponse, DetailFaqResponse>> postFaq(
      {required PostFaqRequest request});
}
