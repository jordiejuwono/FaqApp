import 'package:dartz/dartz.dart';
import 'package:faq_app/common/failure_response.dart';
import 'package:faq_app/data/datasource/local_data_source.dart';
import 'package:faq_app/data/datasource/remote_data_source.dart';
import 'package:faq_app/data/model/request/login_request.dart';
import 'package:faq_app/data/model/response/login_response.dart';
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
}
