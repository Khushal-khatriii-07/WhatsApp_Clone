import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp_clonee/Common/Extension/customThemeExtension.dart';
import 'package:whatsapp_clonee/Common/utils/colors.dart';

ThemeData lightTheme(){
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      backgroundColor: Coloors.backgroundLight,
      scaffoldBackgroundColor: Coloors.backgroundLight,
      extensions: [
         CustomExtensionTheme.lightMode,
      ],
      appBarTheme: AppBarTheme(
          backgroundColor: Coloors.greenLight,
          titleTextStyle: TextStyle(fontSize: 18, color: Coloors.greenDark),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
          ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStatePropertyAll(Coloors.grayLight),
        trackColor: MaterialStatePropertyAll(Coloors.grayLight.withOpacity(0.1)),
        trackOutlineColor: MaterialStatePropertyAll(Coloors.grayLight)
      ),
      tabBarTheme: TabBarTheme(
        indicatorColor: Coloors.backgroundLight,
        labelColor: Coloors.backgroundLight,
        unselectedLabelColor: Colors.white60,
        labelStyle: TextStyle(letterSpacing: 1)
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Coloors.greenLight,
        foregroundColor: Colors.white
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Coloors.greenLight,
          foregroundColor: Coloors.backgroundLight,
          shadowColor: Colors.transparent,
          elevation: 0,
          splashFactory: NoSplash.splashFactory,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)),
        )
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Coloors.backgroundLight,
        modalBackgroundColor: Coloors.backgroundLight,
      ),
      dialogBackgroundColor: Coloors.backgroundLight,
      dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
          )
      ),
      listTileTheme: ListTileThemeData(
          iconColor: Coloors.grayLight,
          tileColor: Coloors.backgroundLight
      ),

  );
}