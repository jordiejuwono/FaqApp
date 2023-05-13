import 'dart:async';

import 'package:faq_app/common/constants.dart';
import 'package:faq_app/common/state_enum.dart';
import 'package:faq_app/presentation/authentication/ui/login_page.dart';
import 'package:faq_app/presentation/home_page/ui/home_page.dart';
import 'package:faq_app/presentation/splash_screen/provider/splash_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "/splash-screen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    final provider = Provider.of<SplashNotifier>(context, listen: false);
    Future.microtask(() {
      provider.isTokenExists();

      Timer(const Duration(seconds: 3), () {
        if (provider.splashState == RequestState.empty ||
            provider.splashState == RequestState.error) {
          Navigator.pushReplacementNamed(context, LoginPage.routeName);
        }
        if (provider.splashState == RequestState.loaded) {
          Navigator.pushReplacementNamed(context, HomePage.routeName);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "FAQ APP",
          style: kHeading5,
        ),
      ),
    );
  }
}
