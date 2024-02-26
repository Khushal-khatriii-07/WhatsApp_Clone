import 'package:flutter/material.dart';
import 'package:whatsapp_clonee/Common/Extension/customThemeExtension.dart';

class yellowCard extends StatelessWidget {
  const yellowCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          color: context.theme.yellowCardBgColor,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Text(
        "Messages and calls are end-to-end encrypted. No one outside of this chat, not even WhatsApp, can read or listen to them. Tap to learn more.",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 13, color: context.theme.yellowCardTextColor),
      ),
    );
  }
}