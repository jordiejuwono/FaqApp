import 'package:faq_app/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LoginFormField extends StatelessWidget {
  final String label;
  final Key formKey;
  final TextEditingController controller;
  final String formName;
  final String? Function(String?)? validators;
  const LoginFormField({
    super.key,
    required this.label,
    required this.formKey,
    required this.controller,
    required this.formName,
    required this.validators,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: kTextMediumBold,
        ),
        FormBuilderTextField(
          key: formKey,
          controller: controller,
          name: formName,
          validator: validators,
        ),
      ],
    );
  }
}
