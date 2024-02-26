import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp_clonee/Common/Extension/customThemeExtension.dart';
import 'package:whatsapp_clonee/Common/utils/colors.dart';

ThemeData darkTheme(){
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    backgroundColor: Coloors.backgroundDark,
    scaffoldBackgroundColor: Coloors.backgroundDark,
    extensions: [
      CustomExtensionTheme.darkMode,
    ],
    appBarTheme: AppBarTheme(
      color: Coloors.grayBackground,
      titleTextStyle: TextStyle(fontSize: 18),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light
      ),
        iconTheme: IconThemeData(
        color: Colors.white
    )
    ),
      switchTheme: SwitchThemeData(
          thumbColor: MaterialStatePropertyAll(Coloors.grayDark),
          trackColor: MaterialStatePropertyAll(Coloors.grayDark.withOpacity(0.1)),
          trackOutlineColor: MaterialStatePropertyAll(Coloors.grayDark)
      ),
    tabBarTheme: TabBarTheme(
      indicatorColor: Coloors.greenDark,
      labelColor: Coloors.greenDark,
      unselectedLabelColor: Colors.white60,
      labelStyle: TextStyle(letterSpacing: 1)
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Coloors.greenDark,
      foregroundColor: Colors.black
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Coloors.greenDark,
        foregroundColor: Coloors.backgroundDark,
        shadowColor: Colors.transparent,
        elevation: 0,
        splashFactory: NoSplash.splashFactory,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)),
      )
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Coloors.grayBackground,
      modalBackgroundColor: Coloors.grayBackground,
    ),
    dialogBackgroundColor: Coloors.grayBackground,
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      )
    ),
    listTileTheme: ListTileThemeData(
      iconColor: Coloors.grayDark,
      tileColor: Coloors.backgroundDark
    )
  );
}