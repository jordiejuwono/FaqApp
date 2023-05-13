import 'package:faq_app/common/state_enum.dart';
import 'package:faq_app/data/model/request/login_request.dart';
import 'package:faq_app/presentation/screen/authentication/provider/login_notifier.dart';
import 'package:faq_app/presentation/screen/home_page/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login-page';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginNotifier>(
      builder: (context, value, child) {
        if (value.loginState == RequestState.loaded) {
          Future.microtask(() {
            Navigator.pushReplacementNamed(context, HomePage.routeName);
          });
        }

        return Scaffold(
          appBar: AppBar(
            title: Text("Login Page"),
          ),
          body: Column(
            children: [
              Text("email"),
              TextField(
                controller: _emailController,
              ),
              Text("password"),
              TextField(
                controller: _passwordController,
              ),
              ElevatedButton(
                  onPressed: () {
                    final loginProvider =
                        Provider.of<LoginNotifier>(context, listen: false);
                    loginProvider.loginUser(LoginRequest(
                        nip: _emailController.text,
                        password: _passwordController.text));
                  },
                  child: Text("Login")),
            ],
          ),
        );
      },
    );
  }
}
