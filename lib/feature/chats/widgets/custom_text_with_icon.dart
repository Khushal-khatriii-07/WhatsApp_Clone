import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clonee/Common/Extension/customThemeExtension.dart';
import 'package:whatsapp_clonee/Common/utils/colors.dart';

class CustomTextWithIcon extends StatelessWidget{
  final IconData icon;
  final String text;

  const CustomTextWithIcon({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 75,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: context.theme.grayColor!.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(15)
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          children: [
            Icon(icon, color: Coloors.greenDark,),
            SizedBox(height: 3,),
            Text(text)
          ],
        ),
      ),
    );
  }

}