import 'package:flutter/material.dart';
import 'package:whatsapp_clonee/Common/Extension/customThemeExtension.dart';
import 'package:whatsapp_clonee/Common/utils/colors.dart';

class PrivacyAndTerms extends StatelessWidget {
  const PrivacyAndTerms({super.key,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: RichText(
        text: TextSpan(
            text: "Read our ",
            style: TextStyle(color: context.theme.grayColor),
            children: [
              TextSpan(
                  text: "Privacy & policy.",
                  style: TextStyle(color: context.theme.blueColor)),
              const TextSpan(
                  text: 'Tap "agree & continue" to accept the'),
              TextSpan(
                  text: "Terms of Services.",
                  style: TextStyle(color: context.theme.blueColor))
            ]),
      ),
    );
  }
}