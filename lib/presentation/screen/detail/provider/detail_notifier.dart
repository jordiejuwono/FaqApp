import 'package:faq_app/common/state_enum.dart';
import 'package:faq_app/data/model/response/detail_faq_response.dart';
import 'package:faq_app/domain/usecase/delete_faq_use_case.dart';
import 'package:faq_app/domain/usecase/fetch_faq_detail_use_case.dart';
import 'package:faq_app/domain/usecase/update_faq_detail_use_case.dart';
import 'package:flutter/material.dart';

class DetailNotifier extends ChangeNotifier {
  final FetchFaqDetailUseCase fetchFaqDetailUseCase;
  final UpdateFaqDetailUseCase updateFaqDetailUseCase;
  final DeleteFaqUseCase deleteFaqUseCase;

  DetailNotifier({
    required this.fetchFaqDetailUseCase,
    required this.updateFaqDetailUseCase,
    required this.deleteFaqUseCase,
  });

  RequestState _faqDetailState = RequestState.loading;
  RequestState get faqDetailState => _faqDetailState;

  RequestState _editFaqState = RequestState.loading;
  RequestState get editFaqState => _editFaqState;

  RequestState _deleteFaqState = RequestState.loading;
  RequestState get deleteFaqState => _deleteFaqState;

  DetailFaqResponse? _faqDetail;
  DetailFaqResponse? get faqDetail => _faqDetail;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  bool _isEditMode = false;
  bool get isEditMode => _isEditMode;

  void changeEditMode(bool isEditMode) {
    _isEditMode = isEditMode;
    notifyListeners();
  }

  Future<void> fetchFaqDetail(int faqId) async {
    _faqDetailState = RequestState.loading;
    notifyListeners();

    final response = await fetchFaqDetailUseCase.execute(faqId);
    response.fold((failure) {
      _errorMessage = failure.errorMessage;
      _faqDetailState = RequestState.error;
      notifyListeners();
    }, (result) {
      _faqDetail = result;
      _faqDetailState = RequestState.loaded;
      notifyListeners();
    });
  }

  Future<void> editFaqDetail(UpdateFaqParams params) async {
    _editFaqState = RequestState.loading;
    notifyListeners();

    final response = await updateFaqDetailUseCase.execute(params);
    response.fold((failure) {
      _errorMessage = failure.errorMessage;
      _editFaqState = RequestState.error;
      notifyListeners();
    }, (result) {
      _faqDetail = result;
      _editFaqState = RequestState.loaded;
      notifyListeners();
    });
  }

  Future<void> deleteFaq(int faqId) async {
    _deleteFaqState = RequestState.loading;
    notifyListeners();

    final response = await deleteFaqUseCase.execute(faqId);
    response.fold((failure) {
      _errorMessage = failure.errorMessage;
      _deleteFaqState = RequestState.error;
      notifyListeners();
    }, (result) {
      _deleteFaqState = RequestState.loaded;
      notifyListeners();
    });
  }
}
