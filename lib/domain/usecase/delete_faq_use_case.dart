import 'package:dartz/dartz.dart';
import 'package:faq_app/common/failure_response.dart';
import 'package:faq_app/common/use_case.dart';
import 'package:faq_app/data/model/response/no_data_response.dart';
import 'package:faq_app/domain/repository/faq_repository.dart';

class DeleteFaqUseCase extends UseCase<NoDataResponse, int> {
  final FaqRepository repository;
  DeleteFaqUseCase({
    required this.repository,
  });

  @override
  Future<Either<FailureResponse, NoDataResponse>> execute(int params) async {
    return await repository.deleteFaq(params);
  }
}
