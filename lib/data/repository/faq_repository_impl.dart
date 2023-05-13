import 'package:dartz/dartz.dart';
import 'package:faq_app/common/failure_response.dart';
import 'package:faq_app/data/datasource/local_data_source.dart';
import 'package:faq_app/data/datasource/remote_data_source.dart';
import 'package:faq_app/data/model/request/login_request.dart';
import 'package:faq_app/data/model/request/post_faq_request.dart';
import 'package:faq_app/data/model/response/faq_list_response.dart';
import 'package:faq_app/data/model/response/login_response.dart';
import 'package:faq_app/data/model/response/no_data_response.dart';
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
      LoginResponse loginResponse) async {
    try {
      final result = await localDataSource.saveBearerToken(loginResponse);
      return Right(result);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<FailureResponse, LoginResponse>> loginUser(
      {required LoginRequest request}) async {
    try {
      final result = await remoteDataSource.loginUser(request: request);
      return Right(result);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<FailureResponse, NoDataResponse>> logoutUser() async {
    try {
      final result = await remoteDataSource.logoutUser();
      return Right(result);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<FailureResponse, FaqListResponse>> fetchFaqList() async {
    try {
      final result = await remoteDataSource.fetchFaqList();
      return Right(result);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<FailureResponse, DetailFaqResponse>> postFaq(
      {required PostFaqRequest request}) async {
    try {
      final result = await remoteDataSource.postFaq(request: request);
      return Right(result);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<FailureResponse, DetailFaqResponse>> fetchFaqDetail(
      int faqId) async {
    try {
      final result = await remoteDataSource.fetchFaqDetail(faqId);
      return Right(result);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<FailureResponse, DetailFaqResponse>> updateFaqDetail(int faqId,
      {required PostFaqRequest request}) async {
    try {
      final result =
          await remoteDataSource.updateFaqDetail(faqId, request: request);
      return Right(result);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<FailureResponse, NoDataResponse>> deleteFaq(int faqId) async {
    try {
      final result = await remoteDataSource.deleteFaq(faqId);
      return Right(result);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<FailureResponse, String>> isTokenExists() async {
    try {
      final result = localDataSource.isTokenExists();
      return Right(result);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<FailureResponse, LoginResponse>> getUserData() async {
    try {
      final result = await localDataSource.getUserData();
      return Right(result);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}
