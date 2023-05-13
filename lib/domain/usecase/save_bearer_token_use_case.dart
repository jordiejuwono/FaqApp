import 'package:dartz/dartz.dart';
import 'package:faq_app/common/failure_response.dart';
import 'package:faq_app/common/use_case.dart';
import 'package:faq_app/domain/repository/faq_repository.dart';

class SaveBearerTokenUseCase extends UseCase<bool, String> {
  final FaqRepository repository;

  SaveBearerTokenUseCase({
    required this.repository,
  });

  @override
  Future<Either<FailureResponse, bool>> execute(String params) async {
    return await repository.saveBearerToken(params);
  }
}
