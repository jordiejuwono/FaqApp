import 'package:faq_app/presentation/authentication/login_notifier.dart';
import 'package:faq_app/presentation/authentication/login_page.dart';
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
          create: (_) => LoginNotifier(
              loginUserUseCase: locator(), saveBearerTokenUseCase: locator()),
          child: LoginPage()),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case LoginPage.routeName:
            return MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider(
                    create: (_) => LoginNotifier(
                        loginUserUseCase: locator(),
                        saveBearerTokenUseCase: locator()),
                    child: const LoginPage()));
          default:
        }
      },
    );
  }
}
