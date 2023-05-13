import 'package:faq_app/common/constants.dart';
import 'package:flutter/material.dart';

class RedBackgroundButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const RedBackgroundButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                onPressed: onPressed,
                child: Text(
                  label,
                  style: kTextMediumNormal,
                ))),
      ],
    );
  }
}
