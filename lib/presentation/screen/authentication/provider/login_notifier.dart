import 'package:faq_app/common/state_enum.dart';
import 'package:faq_app/data/model/request/login_request.dart';
import 'package:faq_app/data/model/response/login_response.dart';
import 'package:faq_app/domain/usecase/login_user_use_case.dart';
import 'package:faq_app/domain/usecase/save_bearer_token_use_case.dart';
import 'package:flutter/material.dart';

class LoginNotifier extends ChangeNotifier {
  final SaveBearerTokenUseCase saveBearerTokenUseCase;
  final LoginUserUseCase loginUserUseCase;

  LoginNotifier({
    required this.saveBearerTokenUseCase,
    required this.loginUserUseCase,
  });

  RequestState _loginState = RequestState.loading;
  RequestState get loginState => _loginState;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> loginUser(LoginRequest request) async {
    _loginState = RequestState.loading;
    notifyListeners();

    final response = await loginUserUseCase.execute(request);
    response.fold((failure) {
      _errorMessage = failure.errorMessage;
      _loginState = RequestState.error;
      notifyListeners();
    }, (response) {
      saveToken(response);
    });
  }

  Future<void> saveToken(LoginResponse loginResponse) async {
    final response = await saveBearerTokenUseCase.execute(loginResponse);
    response.fold((failure) {
      _errorMessage = failure.errorMessage;
      _loginState = RequestState.error;
      notifyListeners();
    }, (response) {
      _loginState = RequestState.loaded;
      notifyListeners();
    });
  }
}
