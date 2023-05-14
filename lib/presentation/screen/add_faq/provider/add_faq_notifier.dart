import 'package:faq_app/common/state_enum.dart';
import 'package:faq_app/data/model/request/post_faq_request.dart';
import 'package:faq_app/domain/usecase/post_faq_use_case.dart';
import 'package:flutter/material.dart';

class AddFaqNotifier extends ChangeNotifier {
  final PostFaqUseCase postFaqUseCase;

  AddFaqNotifier({
    required this.postFaqUseCase,
  });

  RequestState _postFaqState = RequestState.loading;
  RequestState get postFaqState => _postFaqState;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  Future<void> postFaq(PostFaqRequest request) async {
    _postFaqState = RequestState.loading;
    notifyListeners();

    final result = await postFaqUseCase.execute(request);
    result.fold((failure) {
      _errorMessage = failure.errorMessage;
      _postFaqState = RequestState.error;
      notifyListeners();
    }, (result) {
      _postFaqState = RequestState.loaded;
      notifyListeners();
    });
  }
}
