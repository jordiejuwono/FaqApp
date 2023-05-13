import 'package:dartz/dartz.dart';
import 'package:faq_app/common/failure_response.dart';
import 'package:faq_app/common/use_case.dart';
import 'package:faq_app/domain/repository/faq_repository.dart';

class IsTokenExistsUseCase extends UseCase<String, NoParam> {
  final FaqRepository repository;

  IsTokenExistsUseCase({
    required this.repository,
  });

  @override
  Future<Either<FailureResponse, String>> execute(NoParam params) async {
    return await repository.isTokenExists();
  }
}
