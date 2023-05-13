import 'package:dartz/dartz.dart';
import 'package:faq_app/common/failure_response.dart';
import 'package:faq_app/common/use_case.dart';
import 'package:faq_app/data/model/response/detail_faq_response.dart';
import 'package:faq_app/domain/repository/faq_repository.dart';

class UpdateFaqDetailUseCase extends UseCase<DetailFaqResponse, int> {
  final FaqRepository repository;

  UpdateFaqDetailUseCase({
    required this.repository,
  });

  @override
  Future<Either<FailureResponse, DetailFaqResponse>> execute(int params) async {
    return await repository.updateFaqDetail(params);
  }
}
