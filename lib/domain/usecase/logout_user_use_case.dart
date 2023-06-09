import 'package:dartz/dartz.dart';
import 'package:faq_app/common/failure_response.dart';
import 'package:faq_app/common/use_case.dart';
import 'package:faq_app/data/model/response/no_data_response.dart';
import 'package:faq_app/domain/repository/faq_repository.dart';

class LogoutUserUseCase extends UseCase<NoDataResponse, NoParam> {
  final FaqRepository repository;
  LogoutUserUseCase({
    required this.repository,
  });

  @override
  Future<Either<FailureResponse, NoDataResponse>> execute(
      NoParam params) async {
    return await repository.logoutUser();
  }
}
