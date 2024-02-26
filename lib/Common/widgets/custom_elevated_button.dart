import 'package:flutter/material.dart';
import 'package:whatsapp_clonee/Common/utils/colors.dart';


class CustomElevatedButton extends StatelessWidget {
  final double? buttonWidth;
  final VoidCallback onPress;
  final String text;
  const CustomElevatedButton({
    super.key, this.buttonWidth, required this.onPress, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      width: buttonWidth ?? MediaQuery.of(context).size.width - 100,
      child: ElevatedButton(
          onPressed: onPress,
          child: Text(text)),
    );
  }
}