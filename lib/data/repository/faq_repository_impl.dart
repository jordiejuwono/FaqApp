import 'package:dartz/dartz.dart';
import 'package:faq_app/common/failure_response.dart';
import 'package:faq_app/data/datasource/local_data_source.dart';
import 'package:faq_app/data/datasource/remote_data_source.dart';
import 'package:faq_app/data/model/request/login_request.dart';
import 'package:faq_app/data/model/request/post_faq_request.dart';
import 'package:faq_app/data/model/response/faq_list_response.dart';
import 'package:faq_app/data/model/response/login_response.dart';
import 'package:faq_app/data/model/response/logout_response.dart';
import 'package:faq_app/data/model/response/detail_faq_response.dart';
import 'package:faq_app/domain/repository/faq_repository.dart';

class FaqRepositoryImpl implements FaqRepository {
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;

  FaqRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<FailureResponse, bool>> saveBearerToken(
      String bearerToken) async {
    try {
      final response = await localDataSource.saveBearerToken(bearerToken);
      return Right(response);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<FailureResponse, LoginResponse>> loginUser(
      {required LoginRequest request}) async {
    try {
      final response = await remoteDataSource.loginUser(request: request);
      return Right(response);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<FailureResponse, LogoutResponse>> logoutUser() async {
    try {
      final response = await remoteDataSource.logoutUser();
      return Right(response);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<FailureResponse, FaqListResponse>> fetchFaqList() async {
    try {
      final response = await remoteDataSource.fetchFaqList();
      return Right(response);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<FailureResponse, DetailFaqResponse>> postFaq(
      {required PostFaqRequest request}) async {
    try {
      final response = await remoteDataSource.postFaq(request: request);
      return Right(response);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}
