import 'package:dio/dio.dart';
import 'package:faq_app/common/dio_handler.dart';
import 'package:faq_app/data/datasource/local_data_source.dart';
import 'package:faq_app/data/datasource/remote_data_source.dart';
import 'package:faq_app/data/repository/faq_repository_impl.dart';
import 'package:faq_app/domain/repository/faq_repository.dart';
import 'package:faq_app/domain/usecase/delete_faq_use_case.dart';
import 'package:faq_app/domain/usecase/fetch_faq_detail_use_case.dart';
import 'package:faq_app/domain/usecase/fetch_faq_list_use_case.dart';
import 'package:faq_app/domain/usecase/get_user_data_use_case.dart';
import 'package:faq_app/domain/usecase/is_token_exists_use_case.dart';
import 'package:faq_app/domain/usecase/login_user_use_case.dart';
import 'package:faq_app/domain/usecase/logout_user_use_case.dart';
import 'package:faq_app/domain/usecase/post_faq_use_case.dart';
import 'package:faq_app/domain/usecase/save_bearer_token_use_case.dart';
import 'package:faq_app/domain/usecase/update_faq_detail_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> init() async {
  await sharedPreferences();
  _registerDomains();
}

Future<void> sharedPreferences() async {
  final sharedPref = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPref);
}

void _registerDomains() {
  // dio
  locator.registerLazySingleton<Dio>(() => locator<DioHandler>().dio);
  locator.registerLazySingleton<DioHandler>(
      () => DioHandler(sharedPreferences: locator()));

  // data source
  locator.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(dio: locator()));
  locator.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(sharedPreferences: locator(), dio: locator()));

  // repository
  locator.registerLazySingleton<FaqRepository>(() => FaqRepositoryImpl(
      localDataSource: locator(), remoteDataSource: locator()));

  // use case
  locator.registerLazySingleton(() => LoginUserUseCase(repository: locator()));
  locator.registerLazySingleton(
      () => SaveBearerTokenUseCase(repository: locator()));
  locator
      .registerLazySingleton(() => IsTokenExistsUseCase(repository: locator()));
  locator.registerLazySingleton(() => LogoutUserUseCase(repository: locator()));
  locator
      .registerLazySingleton(() => FetchFaqListUseCase(repository: locator()));
  locator.registerLazySingleton(() => PostFaqUseCase(repository: locator()));
  locator.registerLazySingleton(
      () => FetchFaqDetailUseCase(repository: locator()));
  locator.registerLazySingleton(
      () => UpdateFaqDetailUseCase(repository: locator()));
  locator.registerLazySingleton(() => DeleteFaqUseCase(repository: locator()));
  locator
      .registerLazySingleton(() => GetUserDataUseCase(repository: locator()));
}
