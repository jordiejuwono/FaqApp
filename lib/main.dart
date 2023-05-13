import 'package:faq_app/presentation/authentication/provider/login_notifier.dart';
import 'package:faq_app/presentation/authentication/ui/login_page.dart';
import 'package:faq_app/presentation/home_page/provider/home_notifier.dart';
import 'package:faq_app/presentation/home_page/ui/home_page.dart';
import 'package:faq_app/presentation/splash_screen/provider/splash_notifier.dart';
import 'package:faq_app/presentation/splash_screen/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'di/dependency.dart' as di;
import 'di/dependency.dart';

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
                builder: (_) => ChangeNotifierProvider(
                      create: (_) => HomeNotifier(),
                      child: const HomePage(),
                    ));
          default:
        }
      },
    );
  }
}
