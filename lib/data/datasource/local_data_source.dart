import 'dart:convert';

import 'package:faq_app/common/constants.dart';
import 'package:faq_app/common/failure_response.dart';
import 'package:faq_app/data/model/response/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<bool> saveBearerToken(LoginResponse response);
  String isTokenExists();
  Future<LoginResponse> getUserData();
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<bool> saveBearerToken(LoginResponse response) async {
    try {
      await sharedPreferences.setString(
          PreferenceKey.userData, jsonEncode(response.toJson()));
      await sharedPreferences.setString(
          PreferenceKey.bearerToken, response.data?.accessToken ?? "");
      return true;
    } catch (error) {
      throw DatabaseFailure(error.toString());
    }
  }

  @override
  String isTokenExists() {
    return sharedPreferences.getString(PreferenceKey.bearerToken) ?? "";
  }

  @override
  Future<LoginResponse> getUserData() async {
    try {
      if (sharedPreferences.getString(PreferenceKey.userData) == null) {
        return LoginResponse(code: 400, message: "Not Found");
      } else {
        LoginResponse response = LoginResponse.fromJson(jsonDecode(
            sharedPreferences.getString(PreferenceKey.userData) ?? ""));
        return response;
      }
    } catch (error) {
      throw DatabaseFailure(error.toString());
    }
  }
}
