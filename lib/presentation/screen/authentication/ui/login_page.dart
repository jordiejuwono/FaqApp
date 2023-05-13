import 'package:faq_app/common/constants.dart';
import 'package:faq_app/common/state_enum.dart';
import 'package:faq_app/data/model/request/login_request.dart';
import 'package:faq_app/presentation/screen/authentication/provider/login_notifier.dart';
import 'package:faq_app/presentation/screen/home_page/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login-page';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _emailKey = GlobalKey<FormBuilderFieldState>();
  final _passwordKey = GlobalKey<FormBuilderFieldState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
        if (value.loginState == RequestState.error) {
          _emailKey.currentState
              ?.invalidate('Wrong email / password, please check again');
          _passwordKey.currentState
              ?.invalidate('Wrong email / password, please check again');
        }

        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.question_answer_rounded,
                                  size: 90.0,
                                  color: Colors.blue,
                                ),
                                Text(
                                  "FAQ APP",
                                  style: kHeading5.copyWith(
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          "Email",
                          style: kTextMediumBold,
                        ),
                        FormBuilderTextField(
                          key: _emailKey,
                          controller: _emailController,
                          name: "email",
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.email(),
                          ]),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "Password",
                          style: kTextMediumBold,
                        ),
                        FormBuilderTextField(
                          key: _passwordKey,
                          controller: _passwordController,
                          name: "password",
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ]),
                        ),
                        const SizedBox(
                          height: 50.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    _emailKey.currentState?.validate();
                                    _passwordKey.currentState?.validate();

                                    if ((_emailKey.currentState?.isValid ??
                                            true) &&
                                        (_passwordKey.currentState?.isValid ??
                                            true)) {
                                      final loginProvider =
                                          Provider.of<LoginNotifier>(context,
                                              listen: false);
                                      loginProvider.loginUser(LoginRequest(
                                        nip: _emailController.text,
                                        password: _passwordController.text,
                                      ));
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Text(
                                      "Login",
                                      style: kTextMediumNormal,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
