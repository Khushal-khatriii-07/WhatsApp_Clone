import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clonee/Common/Extension/customThemeExtension.dart';
import 'package:whatsapp_clonee/Common/Model/last_message_model.dart';
import 'package:whatsapp_clonee/Common/Model/user_model.dart';
import 'package:whatsapp_clonee/Common/routes/routes.dart';
import 'package:whatsapp_clonee/Common/utils/colors.dart';
import 'package:whatsapp_clonee/feature/chats/widgets/chat_text_field.dart';

class ChatHomePage extends ConsumerWidget {
  navigateToContactPage(context) {
    Navigator.pushNamed(context, Routes.contact);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: StreamBuilder<List<LastMessageModel>>(
        stream: ref.watch(chatControllerProvider).getAllLastMessageList(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Coloors.greenDark,
              ),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final lastMessageData = snapshot.data![index];
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.chat,
                        arguments: UserModel(
                            userName: lastMessageData.userName,
                            lastSeen: 0,
                            userId: lastMessageData.contactId,
                            profileImageUrl: lastMessageData.profileImageUrl,
                            active: true,
                            phoneNumber: '0',
                            groupId: []));
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(lastMessageData.userName),
                      Text(
                        DateFormat.Hm().format(lastMessageData.timeSent),
                        style: TextStyle(
                          fontSize: 13,
                          color: context.theme.grayColor,
                        ),
                      )
                    ],
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(
                      lastMessageData.lastMessage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: context.theme.grayColor),
                    ),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                        lastMessageData.profileImageUrl),
                    radius: 24,
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToContactPage(context),
        child: Icon(Icons.message_rounded),
      ),
    );
  }
}
