// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:whatsapp_clonee/Common/Extension/customThemeExtension.dart';
import 'package:whatsapp_clonee/Common/routes/routes.dart';
import 'package:whatsapp_clonee/Common/utils/colors.dart';
import 'package:whatsapp_clonee/Common/widgets/custom_elevated_button.dart';
import 'package:whatsapp_clonee/feature/auth/pages/login_page.dart';
import 'package:whatsapp_clonee/feature/welcome/Widgets/language_button.dart';
import 'package:whatsapp_clonee/feature/welcome/Widgets/privacy_and_terms.dart';

class WelcomePage extends StatelessWidget {
  nevigateToLoginPage(context){
    Navigator.of(context).pushNamedAndRemoveUntil(Routes.login, (route) => false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: Image.asset(
                  "assets/images/whatsapp_circle.png",
                  color: context.theme.circleImageColor,
                ),
              ),
            )),
            const SizedBox(
              height: 40,
            ),
            Expanded(
                child: Column(
              children: [
                const Text(
                  "Welcome to Whatsapp",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                const PrivacyAndTerms(),
                CustomElevatedButton(onPress: () => nevigateToLoginPage(context), text: 'AGREE AND CONTINUE',),
                SizedBox(
                  height: 40,
                ),
                LanguageButton()
              ],
            ))
          ],
        ));
  }
}


