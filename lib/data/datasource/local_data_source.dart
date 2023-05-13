import 'package:faq_app/common/constants.dart';
import 'package:faq_app/common/failure_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<bool> saveBearerToken(String bearerToken);
  String isTokenExists();
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<bool> saveBearerToken(String bearerToken) async {
    try {
      await sharedPreferences.setString(PreferenceKey.bearerToken, bearerToken);
      return true;
    } catch (error) {
      throw DatabaseFailure(error.toString());
    }
  }

  @override
  String isTokenExists() {
    return sharedPreferences.getString(PreferenceKey.bearerToken) ?? "";
  }
}
