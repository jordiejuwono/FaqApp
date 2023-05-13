import 'package:faq_app/common/utils.dart';
import 'package:faq_app/presentation/screen/authentication/ui/login_page.dart';
import 'package:faq_app/presentation/screen/detail/provider/detail_notifier.dart';
import 'package:faq_app/presentation/screen/detail/ui/detail_page.dart';
import 'package:faq_app/presentation/screen/faq_list/provider/faq_list_notifier.dart';
import 'package:faq_app/presentation/screen/home_page/provider/home_notifier.dart';
import 'package:faq_app/presentation/screen/home_page/ui/home_page.dart';
import 'package:faq_app/presentation/screen/splash_screen/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'di/dependency.dart' as di;
import 'di/dependency.dart';
import 'presentation/screen/authentication/provider/login_notifier.dart';
import 'presentation/screen/splash_screen/provider/splash_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const FaqApp());
}

class FaqApp extends StatelessWidget {
  const FaqApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
          create: (_) => SplashNotifier(
                isTokenExistsUseCase: locator(),
              ),
          child: const SplashScreen()),
      navigatorObservers: [
        routeObserver,
      ],
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case LoginPage.routeName:
            return MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider(
                    create: (_) => LoginNotifier(
                          loginUserUseCase: locator(),
                          saveBearerTokenUseCase: locator(),
                        ),
                    child: const LoginPage()));
          case HomePage.routeName:
            return MaterialPageRoute(
                builder: (_) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(
                          create: (_) => HomeNotifier(),
                        ),
                        ChangeNotifierProvider(
                            create: (_) =>
                                FaqListNotifier(fetchFaqListUseCase: locator()))
                      ],
                      child: const HomePage(),
                    ));
          case DetailPage.routeName:
            return MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider(
                      create: (_) => DetailNotifier(
                          fetchFaqDetailUseCase: locator(),
                          updateFaqDetailUseCase: locator(),
                          deleteFaqUseCase: locator()),
                      child: DetailPage(
                        faqId: settings.arguments as int,
                      ),
                    ));
          default:
        }
      },
    );
  }
}
