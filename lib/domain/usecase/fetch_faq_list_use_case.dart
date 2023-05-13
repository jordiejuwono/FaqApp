import 'package:dartz/dartz.dart';
import 'package:faq_app/common/failure_response.dart';
import 'package:faq_app/common/use_case.dart';
import 'package:faq_app/data/model/response/faq_list_response.dart';
import 'package:faq_app/domain/repository/faq_repository.dart';

class FetchFaqListUseCase extends UseCase<FaqListResponse, NoParam> {
  final FaqRepository repository;

  FetchFaqListUseCase({
    required this.repository,
  });

  @override
  Future<Either<FailureResponse, FaqListResponse>> execute(
      NoParam params) async {
    return await repository.fetchFaqList();
  }
}
