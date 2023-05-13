import 'package:dartz/dartz.dart';
import 'package:faq_app/common/failure_response.dart';
import 'package:faq_app/common/use_case.dart';
import 'package:faq_app/data/model/response/detail_faq_response.dart';
import 'package:faq_app/domain/repository/faq_repository.dart';

class FetchFaqDetailUseCase extends UseCase<DetailFaqResponse, int> {
  final FaqRepository repository;

  FetchFaqDetailUseCase({
    required this.repository,
  });

  @override
  Future<Either<FailureResponse, DetailFaqResponse>> execute(int params) async {
    return await repository.fetchFaqDetail(params);
  }
}
