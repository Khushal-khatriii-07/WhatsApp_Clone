import 'package:flutter/material.dart';
import 'package:whatsapp_clonee/Common/Extension/customThemeExtension.dart';
import 'package:whatsapp_clonee/Common/utils/colors.dart';

showAlertDialog({required BuildContext context, required String message, String? btnText}) {
  return showDialog(context: context, builder: (context){
    return AlertDialog(
      content: Text(message, style: TextStyle(color: context.theme.grayColor),),
      contentPadding: EdgeInsets.all(20),
      backgroundColor: Coloors.grayBackground,
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.transparent)),
            child: Text(
              btnText ?? "Ok",
              style: TextStyle(color: context.theme.circleImageColor),
            )),
      ],
    );
  });
}