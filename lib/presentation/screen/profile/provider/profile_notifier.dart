import 'package:faq_app/common/state_enum.dart';
import 'package:faq_app/common/use_case.dart';
import 'package:faq_app/data/model/response/login_response.dart';
import 'package:faq_app/domain/usecase/get_user_data_use_case.dart';
import 'package:flutter/material.dart';

class ProfileNotifier extends ChangeNotifier {
  final GetUserDataUseCase getUserDataUseCase;

  ProfileNotifier({
    required this.getUserDataUseCase,
  });

  RequestState _profileState = RequestState.loading;
  RequestState get profileState => _profileState;

  LoginResponse? _userData;
  LoginResponse? get userData => _userData;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  Future<void> getUserData() async {
    _profileState = RequestState.loading;
    notifyListeners();

    final response = await getUserDataUseCase.execute(const NoParam());
    response.fold((failure) {
      _errorMessage = failure.errorMessage;
      _profileState = RequestState.error;
      notifyListeners();
    }, (result) {
      print(result.data?.email);
      _userData = result;
      _profileState = RequestState.loaded;
      notifyListeners();
    });
  }
}
