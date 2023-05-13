import 'package:dartz/dartz.dart';
import 'package:faq_app/common/failure_response.dart';
import 'package:faq_app/common/use_case.dart';
import 'package:faq_app/data/model/request/post_faq_request.dart';
import 'package:faq_app/data/model/response/detail_faq_response.dart';
import 'package:faq_app/domain/repository/faq_repository.dart';

class PostFaqUseCase extends UseCase<DetailFaqResponse, PostFaqRequest> {
  final FaqRepository repository;

  PostFaqUseCase({
    required this.repository,
  });

  @override
  Future<Either<FailureResponse, DetailFaqResponse>> execute(
      PostFaqRequest params) async {
    return await repository.postFaq(request: params);
  }
}
