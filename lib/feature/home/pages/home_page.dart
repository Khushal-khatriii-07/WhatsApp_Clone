import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clonee/Common/widgets/custom_icon_button.dart';
import 'package:whatsapp_clonee/feature/auth/controller/auth_controller.dart';
import 'package:whatsapp_clonee/feature/home/pages/call_home_page.dart';
import 'package:whatsapp_clonee/feature/home/pages/chat_home_page.dart';
import 'package:whatsapp_clonee/feature/home/pages/status_home_page.dart';

class HomePage extends ConsumerStatefulWidget{
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {

  late Timer timer;

  updateUserPresence(){
    ref.read(authControllerProvider).updateUserPresence();
  }

  @override
  void initState() {
    updateUserPresence();
    timer = Timer.periodic(const Duration(minutes: 1), (timer) => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('WhatsApp', style: TextStyle(letterSpacing: 1, color: Colors.white)),
          actions: [
            CustomIconButton(icon: Icons.search, onTap: (){}),
            CustomIconButton(icon: Icons.more_vert, onTap: (){})
          ],
          bottom: TabBar(
            indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              splashFactory: NoSplash.splashFactory,
              tabs: [
                Tab(text: 'Chats'),
                Tab(text: 'Updates'),
                Tab(text: 'Calls')
          ]),
        ),
        body: TabBarView(
          children: [
            ChatHomePage(),
            StatusHomePage(),
            CallHomePage()
          ],
        ),
      ),
    );
  }
}