import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clonee/Common/Extension/customThemeExtension.dart';
import 'package:whatsapp_clonee/Common/utils/colors.dart';

class CustomTextField extends StatelessWidget{

  final TextEditingController? controller;
  final String? hintText;
  final bool? readOnly;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final String? prefixText;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final double? textSize;
  final bool? autoFocus;

  const CustomTextField({super.key, this.controller, this.hintText, this.readOnly, this.textAlign, this.keyboardType, this.prefixText, this.onTap, this.suffixIcon, this.onChanged, this.textSize, this.autoFocus});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      textAlign: textAlign ?? TextAlign.center,
      readOnly: readOnly ?? false,
      keyboardType: readOnly==null ? keyboardType : null,
      onChanged: onChanged,
      decoration: InputDecoration(
        isDense: true,
        prefixText: prefixText,
        suffix: suffixIcon,
        hintText: hintText,
        hintStyle: TextStyle(color: context.theme.grayColor),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Coloors.greenDark),
        ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Coloors.greenDark, width: 2),
          )
      ),
      style: TextStyle(fontSize: textSize),
      cursorColor: context.theme.circleImageColor,
      autofocus: autoFocus ?? false,
    );
  }
  
}