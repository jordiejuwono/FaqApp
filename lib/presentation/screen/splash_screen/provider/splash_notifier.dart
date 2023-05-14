import 'package:faq_app/common/state_enum.dart';
import 'package:faq_app/common/use_case.dart';
import 'package:faq_app/domain/usecase/is_token_exists_use_case.dart';
import 'package:flutter/material.dart';

class SplashNotifier extends ChangeNotifier {
  final IsTokenExistsUseCase isTokenExistsUseCase;

  SplashNotifier({
    required this.isTokenExistsUseCase,
  });

  RequestState _splashState = RequestState.loading;
  RequestState get splashState => _splashState;

  void isTokenExists() async {
    _splashState = RequestState.loading;
    notifyListeners();

    final response = await isTokenExistsUseCase.execute(const NoParam());
    response.fold((failure) {
      _splashState = RequestState.error;
      notifyListeners();
    }, (result) {
      if (result.isNotEmpty && result != "") {
        _splashState = RequestState.loaded;
        notifyListeners();
      } else {
        _splashState = RequestState.empty;
        notifyListeners();
      }
    });
  }
}
