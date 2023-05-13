import 'package:dartz/dartz.dart';
import 'package:faq_app/common/failure_response.dart';
import 'package:faq_app/data/model/request/login_request.dart';
import 'package:faq_app/data/model/request/post_faq_request.dart';
import 'package:faq_app/data/model/response/faq_list_response.dart';
import 'package:faq_app/data/model/response/login_response.dart';
import 'package:faq_app/data/model/response/no_data_response.dart';
import 'package:faq_app/data/model/response/detail_faq_response.dart';

abstract class FaqRepository {
  // local
  Future<Either<FailureResponse, bool>> saveBearerToken(LoginResponse response);
  Future<Either<FailureResponse, String>> isTokenExists();
  Future<Either<FailureResponse, LoginResponse>> getUserData();

  // remote
  Future<Either<FailureResponse, LoginResponse>> loginUser(
      {required LoginRequest request});
  Future<Either<FailureResponse, NoDataResponse>> logoutUser();
  Future<Either<FailureResponse, FaqListResponse>> fetchFaqList();
  Future<Either<FailureResponse, DetailFaqResponse>> postFaq(
      {required PostFaqRequest request});
  Future<Either<FailureResponse, DetailFaqResponse>> fetchFaqDetail(int faqId);
  Future<Either<FailureResponse, DetailFaqResponse>> updateFaqDetail(int faqId,
      {required PostFaqRequest request});
  Future<Either<FailureResponse, NoDataResponse>> deleteFaq(int faqId);
}
