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
    print("TEST");
    _faqListState = RequestState.loading;
    notifyListeners();

    final response = await fetchFaqListUseCase.execute(const NoParam());
    response.fold((failure) {
      print("TEST 1");
      print(failure.errorMessage);
      _errorMessage = failure.errorMessage;
      _faqListState = RequestState.error;
      notifyListeners();
    }, (result) {
      print('TEST 2');
      print(result.data[0].pertanyaan);
      _faqList = result;
      _faqListState = RequestState.loaded;
      notifyListeners();
    });
  }
}
