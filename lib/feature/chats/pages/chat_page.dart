import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:whatsapp_clonee/Common/Extension/customThemeExtension.dart';
import 'package:whatsapp_clonee/Common/Model/message_model.dart';
import 'package:whatsapp_clonee/Common/Model/user_model.dart';
import 'package:whatsapp_clonee/Common/routes/routes.dart';
import 'package:whatsapp_clonee/Common/widgets/custom_icon_button.dart';
import 'package:whatsapp_clonee/feature/chats/widgets/chat_text_field.dart';
import 'package:whatsapp_clonee/feature/chats/widgets/message_card.dart';
import 'package:whatsapp_clonee/feature/chats/widgets/show_date_card.dart';
import 'package:whatsapp_clonee/feature/chats/widgets/yellow_card.dart';

final pageStorageBucket = PageStorageBucket();

class ChatPage extends ConsumerWidget {
  final UserModel user;
  final ScrollController scrollController = ScrollController();
  ChatPage({super.key, required this.user});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: context.theme.chatPageBgColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          borderRadius: BorderRadius.circular(20),
          child: Row(
            children: [
              Icon(Icons.arrow_back),
              Hero(
                tag: 'profile',
                child: Container(
                  width: 32,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(user.profileImageUrl),
                      )),
                ),
              ),
            ],
          ),
        ),
        title: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(Routes.profile, arguments: user);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.userName,
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
                Text(
                  'last seen 2 minute ago',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                )
              ],
            ),
          ),
        ),
        actions: [
          CustomIconButton(
            icon: CupertinoIcons.videocam_fill,
            onTap: () {},
            iconSize: 25,
          ),
          CustomIconButton(icon: Icons.call_rounded, onTap: () {}),
          CustomIconButton(icon: Icons.more_vert, onTap: () {}),
        ],
      ),
      body: Stack(
        children: [
          Image(
            height: double.maxFinite,
            width: double.maxFinite,
            image: AssetImage("assets/images/doodle_bg.png"),
            fit: BoxFit.cover,
            color: context.theme.chatPageDoodleColor!.withOpacity(0.4),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: StreamBuilder(
              stream: ref
                  .watch(chatControllerProvider)
                  .getAllOneToOneMessage(user.userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.active) {
                  return ListView.builder(
                      itemCount: 15,
                      itemBuilder: (_, index) {
                        final random = Random().nextInt(14);
                        return Container(
                          alignment: random.isEven
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          margin: EdgeInsets.only(
                            top: 5,
                            bottom: 5,
                            left: random.isEven ? 150 : 15,
                            right: random.isEven ? 15 : 150,
                          ),
                          child: ClipPath(
                            clipper: UpperNipMessageClipperTwo(
                              random.isEven
                                  ? MessageType.send
                                  : MessageType.receive,
                              nipWidth: 8,
                              nipHeight: 10,
                              bubbleRadius: 12,
                            ),
                            child: Shimmer.fromColors(
                                child: Container(
                                  height: 35,
                                  width: 180 +
                                      double.parse((random * 2).toString()),
                                  color: Colors.red,
                                ),
                                baseColor: random.isEven
                                    ? context.theme.grayColor!.withOpacity(.3)
                                    : context.theme.grayColor!.withOpacity(.2),
                                highlightColor: random.isEven
                                    ? context.theme.grayColor!.withOpacity(.4)
                                    : context.theme.grayColor!.withOpacity(.3)),
                          ),
                        );
                      });
                }
                return PageStorage(
                  bucket: pageStorageBucket,
                  child: ListView.builder(
                      key: const PageStorageKey('chat_page_list'),
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      controller: scrollController,
                      itemBuilder: (_, index) {
                        final message = snapshot.data![index];
                        final isSender = message.senderId ==
                            FirebaseAuth.instance.currentUser!.uid;
                        final haveNip = (index == 0) ||
                            (index == snapshot.data!.length - 1 &&
                                message.senderId !=
                                    snapshot.data![index - 1].senderId) ||
                            (message.senderId !=
                                    snapshot.data![index - 1].senderId &&
                                message.senderId ==
                                    snapshot.data![index + 1].senderId) ||
                            (message.senderId !=
                                    snapshot.data![index - 1].senderId &&
                                message.senderId ==
                                    snapshot.data![index + 1].senderId);
                        final isShowDateCard = (index == 0) ||
                            ((index == snapshot.data!.length - 1) &&
                                (message.timeSent.day >
                                    snapshot.data![index - 1].timeSent.day)) ||
                            (message.timeSent.day >
                                    snapshot.data![index - 1].timeSent.day &&
                                message.timeSent.day <=
                                    snapshot.data![index + 1].timeSent.day);
                        return Column(
                          children: [
                            if (index == 0) yellowCard(),
                            if(isShowDateCard)
                              ShowDateCard(date: message.timeSent),
                            MessageCard(
                                isSender: isSender,
                                haveNip: haveNip,
                                message: message),
                          ],
                        );
                      }),
                );
              },
            ),
          ),
          Container(
            alignment: Alignment(0, 1),
            child: ChatTextField(
             receiverId: user.userId, scrollController: scrollController)),
        ],
      ),
    );
  }
}
