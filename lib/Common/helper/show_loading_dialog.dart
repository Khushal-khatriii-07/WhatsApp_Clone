import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clonee/Common/Extension/customThemeExtension.dart';
import 'package:whatsapp_clonee/Common/utils/colors.dart';

showLoadingDialog({
  required BuildContext context,
  required String message
})async{
  return await showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  CircularProgressIndicator(
                    color: Coloors.greenDark,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(child: Text(
                    message,
                    style: TextStyle(fontSize: 15, color: context.theme.grayColor, height: 1.5),
                  ))
                ],
              )
            ],
          ),
        );
      }
      );
}