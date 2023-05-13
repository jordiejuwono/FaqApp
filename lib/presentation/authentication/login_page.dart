import 'package:faq_app/data/model/request/login_request.dart';
import 'package:faq_app/presentation/authentication/login_notifier.dart';
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
              child: Text("Login"))
        ],
      ),
    );
  }
}
