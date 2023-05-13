import 'package:dartz/dartz.dart';
import 'package:faq_app/common/failure_response.dart';
import 'package:faq_app/common/use_case.dart';
import 'package:faq_app/data/model/request/login_request.dart';
import 'package:faq_app/data/model/response/login_response.dart';
import 'package:faq_app/domain/repository/faq_repository.dart';

class LoginUserUseCase extends UseCase<LoginResponse, LoginRequest> {
  final FaqRepository repository;

  LoginUserUseCase({
    required this.repository,
  });

  @override
  Future<Either<FailureResponse, LoginResponse>> execute(
      LoginRequest params) async {
    return await repository.loginUser(request: params);
  }
}
