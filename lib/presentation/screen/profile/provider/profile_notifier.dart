import 'package:faq_app/common/state_enum.dart';
import 'package:faq_app/common/use_case.dart';
import 'package:faq_app/data/model/response/login_response.dart';
import 'package:faq_app/domain/usecase/get_user_data_use_case.dart';
import 'package:faq_app/domain/usecase/logout_user_use_case.dart';
import 'package:flutter/material.dart';

class ProfileNotifier extends ChangeNotifier {
  final GetUserDataUseCase getUserDataUseCase;
  final LogoutUserUseCase logoutUserUseCase;

  ProfileNotifier({
    required this.getUserDataUseCase,
    required this.logoutUserUseCase,
  });

  RequestState _profileState = RequestState.loading;
  RequestState get profileState => _profileState;

  RequestState _logoutState = RequestState.loading;
  RequestState get logoutState => _logoutState;

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
      _userData = result;
      _profileState = RequestState.loaded;
      notifyListeners();
    });
  }

  Future<void> logoutUser() async {
    _logoutState = RequestState.loading;
    notifyListeners();

    final response = await logoutUserUseCase.execute(const NoParam());
    response.fold((failure) {
      _errorMessage = failure.errorMessage;
      _logoutState = RequestState.error;
      notifyListeners();
    }, (result) {
      _logoutState = RequestState.loaded;
      notifyListeners();
    });
  }
}
