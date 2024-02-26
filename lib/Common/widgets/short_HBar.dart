import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:whatsapp_clonee/Common/Extension/customThemeExtension.dart';

class ShortHBar extends StatelessWidget{
  final double? height;
  final double? width;
  final Color? color;

  const ShortHBar({super.key, this.height, this.width, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        height: height ?? 4,
        width: width ?? 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color ?? context.theme.grayColor!.withOpacity(0.3),
        ),
      ),
    );
  }
}