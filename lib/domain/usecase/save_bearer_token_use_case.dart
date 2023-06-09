import 'package:dartz/dartz.dart';
import 'package:faq_app/common/failure_response.dart';
import 'package:faq_app/common/use_case.dart';
import 'package:faq_app/data/model/response/login_response.dart';
import 'package:faq_app/domain/repository/faq_repository.dart';

class SaveBearerTokenUseCase extends UseCase<bool, LoginResponse> {
  final FaqRepository repository;

  SaveBearerTokenUseCase({
    required this.repository,
  });

  @override
  Future<Either<FailureResponse, bool>> execute(LoginResponse params) async {
    return await repository.saveBearerToken(params);
  }
}
