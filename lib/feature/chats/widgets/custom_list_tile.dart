import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clonee/Common/Extension/customThemeExtension.dart';

class CustomListTile extends StatelessWidget{
  final String title;
  final String? subtitle;
  final IconData leading;
  final Widget? trailing;
  final Color? color;

  const CustomListTile({super.key, required this.title, this.subtitle, required this.leading, this.trailing, this.color});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){},
      contentPadding: EdgeInsets.fromLTRB(20, 5, 10, 0),
      title: Text(title, style: TextStyle(fontSize: 18, color: color),),
      subtitle: subtitle != null ? Text(subtitle!, style: TextStyle(color: context.theme.grayColor),) : null,
      leading: Icon(leading, color: color ?? context.theme.grayColor),
      trailing: trailing,
    );
  }

}