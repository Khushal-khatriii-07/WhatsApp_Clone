import 'package:flutter/material.dart';
import 'package:whatsapp_clonee/Common/Extension/customThemeExtension.dart';
import 'package:whatsapp_clonee/Common/utils/colors.dart';
import 'package:whatsapp_clonee/Common/widgets/custom_icon_button.dart';


class LanguageButton extends StatelessWidget {
  const LanguageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      color: context.theme.lngBtnBgColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => showModelSheet(context),
        highlightColor: context.theme.lngBtnHighlightColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.language,
                color: Coloors.greenDark,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "English",
                style: TextStyle(color: Coloors.greenDark),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: Coloors.greenDark,
              ),
            ],
          ),
        ),
      ),
    );
  }

  showModelSheet(context) {
    return showModalBottomSheet(
        context: context,
        builder: (context){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 4,
                  width: 30,
                  // color: context.theme.grayColor!.withOpacity(0.4),
                  decoration: BoxDecoration(
                    color: context.theme.grayColor!.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    CustomIconButton(icon: Icons.close_outlined, onTap: () => Navigator.of(context).pop()),
                    SizedBox(width: 10),
                    Text(
                      "App Language",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    )
                  ],
                ),
                Divider(
                  thickness: .5,
                  color: context.theme.grayColor!.withOpacity(0.4),
                ),
                RadioListTile(
                    value: true,
                    groupValue: true,
                    onChanged: (value){},
                    activeColor: Coloors.greenDark,
                    title: Text('English'),
                    subtitle: Text("(phone's language)", style: TextStyle(color: context.theme.grayColor)),
                ),
                RadioListTile(
                  value: true,
                  groupValue: false,
                  onChanged: (value){},
                  activeColor: Coloors.greenDark,
                  title: Text('አማርኛ'),
                  subtitle: Text("Amharic", style: TextStyle(color: context.theme.grayColor)),
                ),
              ],
            ),
          );
        });
  }
}