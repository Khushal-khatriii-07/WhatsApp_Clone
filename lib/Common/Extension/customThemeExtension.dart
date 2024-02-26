import 'package:flutter/material.dart';
import 'package:whatsapp_clonee/Common/utils/colors.dart';

extension ExtendedTheme on BuildContext {
  CustomExtensionTheme get theme {
    return Theme.of(this).extension<CustomExtensionTheme>()!;
  }
}

class CustomExtensionTheme extends ThemeExtension<CustomExtensionTheme> {
  static const lightMode = CustomExtensionTheme(
      circleImageColor: Color(0xFF25D366),
      grayColor: Coloors.grayLight,
      blueColor: Coloors.blueLight,
      lngBtnBgColor: Color(0xFFF7F8FA),
      lngBtnHighlightColor: Color(0xFFE8E8ED),
      photoIconBgColor: Color(0xFFF0F2F3),
      photoIconColor: Color(0xFF9DAAB3),
      profilePageBg: Color(0xFFF7F8FA),
      listTileBg: Color(0xFFFFFFFF),
    chatTextFieldBg: Colors.white,
    chatPageBgColor: Color(0xFFEFE7DE),
    chatPageDoodleColor: Colors.white70,
    senderChatCardBg: Color(0xFFE7FFDB),
    receiverChatCardBg: Color(0xFFFFFFFF),
    yellowCardBgColor: Color.fromARGB(73, 255, 220, 121),
    yellowCardTextColor: Color(0xCD2B333E),

  );
  static const darkMode = CustomExtensionTheme(
    circleImageColor: Coloors.greenDark,
    grayColor: Coloors.grayDark,
    blueColor: Coloors.blueDark,
    lngBtnBgColor: Color(0xFF182229),
    lngBtnHighlightColor: Color(0xFF09141A),
    photoIconBgColor: Color(0xFF283339),
    photoIconColor: Color(0xFF61717B),
    profilePageBg: Color(0xFF0B141A),
    listTileBg: Color(0xFF111B21),
    chatTextFieldBg: Coloors.grayBackground,
    chatPageBgColor: Color(0xFF081419),
    chatPageDoodleColor: Color(0xFF172428),
    senderChatCardBg: Color(0xFF005C4B),
    receiverChatCardBg: Coloors.grayBackground,
    yellowCardBgColor: Color(0xCD2B333E),
    yellowCardTextColor: Color.fromARGB(255, 255, 220, 121),
  );
  final Color? circleImageColor;
  final Color? grayColor;
  final Color? blueColor;
  final Color? lngBtnBgColor;
  final Color? lngBtnHighlightColor;
  final Color? photoIconBgColor;
  final Color? photoIconColor;
  final Color? profilePageBg;
  final Color? listTileBg;
  final Color? chatTextFieldBg;
  final Color? chatPageBgColor;
  final Color? chatPageDoodleColor;
  final Color? senderChatCardBg;
  final Color? receiverChatCardBg;
  final Color? yellowCardBgColor;
  final Color? yellowCardTextColor;

  const CustomExtensionTheme(
      {required this.circleImageColor,
      required this.grayColor,
      required this.blueColor,
      required this.lngBtnBgColor,
      required this.lngBtnHighlightColor,
      required this.photoIconBgColor,
      required this.photoIconColor,
      required this.profilePageBg,
      required this.listTileBg,
      required this.chatTextFieldBg,
      required this.chatPageBgColor,
        required this.chatPageDoodleColor,
      required this.senderChatCardBg,
      required this.receiverChatCardBg,
      required this.yellowCardBgColor,
      required this.yellowCardTextColor,
      });

  @override
  ThemeExtension<CustomExtensionTheme> copyWith({
    Color? circleImageColor,
    Color? grayColor,
    Color? blueColor,
    Color? lngBtnBgColor,
    Color? lngBtnHighlightColor,
    Color? photoIconBgColor,
    Color? photoIconColor,
    Color? profilePageBg,
    Color? listTileBg,
    Color? chatTextFieldBg,
    Color? chatPageBgColor,
    Color? chatPageDoodleColor,
    Color? senderChatCardBg,
    Color? receiverChatCardBg,
    Color? yellowCardBgColor,
    Color? yellowCardTextColor,
  }) {
    return CustomExtensionTheme(
        circleImageColor: circleImageColor ?? this.circleImageColor,
        grayColor: grayColor ?? this.grayColor,
        blueColor: blueColor ?? this.blueColor,
        lngBtnBgColor: lngBtnBgColor ?? this.lngBtnBgColor,
        lngBtnHighlightColor: lngBtnHighlightColor ?? this.lngBtnHighlightColor,
        photoIconBgColor: photoIconBgColor ?? this.photoIconBgColor,
        photoIconColor: photoIconColor ?? this.photoIconColor,
        profilePageBg: profilePageBg ?? this.profilePageBg,
        listTileBg: listTileBg ?? this.listTileBg,
        chatTextFieldBg: chatTextFieldBg?? this.chatTextFieldBg,
        chatPageBgColor: chatPageBgColor ?? this.chatPageBgColor,
        chatPageDoodleColor: chatPageDoodleColor ?? this.chatPageDoodleColor,
        senderChatCardBg: senderChatCardBg ?? this.senderChatCardBg,
        receiverChatCardBg: receiverChatCardBg ?? this.receiverChatCardBg,
        yellowCardBgColor: yellowCardBgColor ?? this.yellowCardBgColor,
        yellowCardTextColor: yellowCardTextColor ?? this.yellowCardTextColor
    );
  }

  @override
  ThemeExtension<CustomExtensionTheme> lerp(
      covariant ThemeExtension<CustomExtensionTheme>? other, double t) {
    if (other is! CustomExtensionTheme) return this;
    return CustomExtensionTheme(
        circleImageColor:
            Color.lerp(circleImageColor, other.circleImageColor, t),
        grayColor: Color.lerp(grayColor, other.grayColor, t),
        blueColor: Color.lerp(blueColor, other.blueColor, t),
        lngBtnBgColor: Color.lerp(lngBtnBgColor, other.lngBtnBgColor, t),
        lngBtnHighlightColor:
            Color.lerp(lngBtnHighlightColor, other.lngBtnHighlightColor, t),
        photoIconBgColor:
            Color.lerp(photoIconBgColor, other.photoIconBgColor, t),
        photoIconColor: Color.lerp(photoIconColor, other.photoIconColor, t),
        profilePageBg: Color.lerp(profilePageBg, other.profilePageBg, t),
        listTileBg: Color.lerp(listTileBg, other.listTileBg, t),
        chatTextFieldBg: Color.lerp(chatTextFieldBg, other.chatTextFieldBg, t),
        chatPageBgColor: Color.lerp(chatPageBgColor, other.chatPageBgColor, t),
        chatPageDoodleColor: Color.lerp(chatPageDoodleColor, other.chatPageDoodleColor, t),
        senderChatCardBg: Color.lerp(senderChatCardBg, other.senderChatCardBg, t),
        receiverChatCardBg: Color.lerp(receiverChatCardBg, other.receiverChatCardBg, t),
        yellowCardBgColor: Color.lerp(yellowCardBgColor, other.yellowCardBgColor, t),
        yellowCardTextColor: Color.lerp(yellowCardTextColor, other.yellowCardTextColor, t));
  }
}
