// import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:whatsapp_clonee/Common/Model/user_model.dart';
import 'package:whatsapp_clonee/feature/auth/pages/login_page.dart';
import 'package:whatsapp_clonee/feature/auth/pages/user_info_screen.dart';
import 'package:whatsapp_clonee/feature/auth/pages/verification_page.dart';
import 'package:whatsapp_clonee/feature/chats/pages/chat_page.dart';
import 'package:whatsapp_clonee/feature/chats/pages/profile_page.dart';
import 'package:whatsapp_clonee/feature/contact/pages/contact_page.dart';
import 'package:whatsapp_clonee/feature/home/pages/home_page.dart';
import 'package:whatsapp_clonee/feature/welcome/pages/welcome_page.dart';

class Routes{
  static const String welcome = 'welcome';
  static const String login = 'login';
  static const String verification = 'verification';
  static const String userInfo = 'user-info';
  static const String home = 'home';
  static const String contact = 'contact';
  static const String chat = 'chat';
  static const String profile = 'profile';

  static Route<dynamic> onGenerateRoute(RouteSettings settings){
    switch(settings.name){
      case welcome:
        return MaterialPageRoute(builder: (context)=> WelcomePage());
      case login:
        return MaterialPageRoute(builder: (context)=> LoginPage());
      case home:
        return MaterialPageRoute(builder: (context)=> HomePage());
      case contact:
        return MaterialPageRoute(builder: (context)=> ContactPage());
      case chat:
        final UserModel user = settings.arguments as UserModel;
        return MaterialPageRoute(builder: (context)=> ChatPage(user: user,));
      case profile:
        final UserModel user = settings.arguments as UserModel;
        return PageTransition(child: ProfilePage(user: user,), type: PageTransitionType.fade, duration: Duration(milliseconds: 500));
      case verification:
        final Map args = settings.arguments as Map;
        return MaterialPageRoute(builder: (context)=> VerificationPage(smsCodeId: args['smsCodeId'], phoneNumber: args['phoneNumber'],));
      case userInfo:
        final String? profileImageUrl = settings.arguments as String?;
        return MaterialPageRoute(builder: (context)=> UserInformation(profileImageUrl: profileImageUrl,));
      default:
        return MaterialPageRoute(builder: (context) => const Scaffold(
          body: Center(
            child: Text('No page Route Provided'),
          ),
        ));
    }
  }
}