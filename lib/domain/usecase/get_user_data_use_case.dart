import 'package:dartz/dartz.dart';
import 'package:faq_app/common/failure_response.dart';
import 'package:faq_app/common/use_case.dart';
import 'package:faq_app/data/model/response/login_response.dart';
import 'package:faq_app/domain/repository/faq_repository.dart';

class GetUserDataUseCase extends UseCase<LoginResponse, NoParam> {
  final FaqRepository repository;
  GetUserDataUseCase({
    required this.repository,
  });

  @override
  Future<Either<FailureResponse, LoginResponse>> execute(NoParam params) async {
    return await repository.getUserData();
  }
}
