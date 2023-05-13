import 'package:faq_app/common/state_enum.dart';
import 'package:faq_app/common/use_case.dart';
import 'package:faq_app/data/model/response/faq_list_response.dart';
import 'package:faq_app/domain/usecase/fetch_faq_list_use_case.dart';
import 'package:flutter/material.dart';

class FaqListNotifier extends ChangeNotifier {
  final FetchFaqListUseCase fetchFaqListUseCase;
  FaqListNotifier({
    required this.fetchFaqListUseCase,
  });

  RequestState _faqListState = RequestState.loading;
  RequestState get faqListState => _faqListState;

  FaqListResponse? _faqList;
  FaqListResponse? get faqList => _faqList;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  Future<void> fetchFaqList() async {
    _faqListState = RequestState.loading;
    notifyListeners();

    final response = await fetchFaqListUseCase.execute(const NoParam());
    response.fold((failure) {
      _errorMessage = failure.errorMessage;
      _faqListState = RequestState.error;
      notifyListeners();
    }, (result) {
      _faqList = result;
      _faqListState = RequestState.loaded;
      notifyListeners();
    });
  }
}
