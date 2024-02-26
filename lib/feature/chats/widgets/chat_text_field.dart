import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clonee/Common/Extension/customThemeExtension.dart';
import 'package:whatsapp_clonee/Common/enum/message_type.dart';
import 'package:whatsapp_clonee/Common/utils/colors.dart';
import 'package:whatsapp_clonee/Common/widgets/custom_icon_button.dart';
import 'package:whatsapp_clonee/feature/auth/pages/image_picker.dart';
import 'package:whatsapp_clonee/feature/chats/controllers/chat_controller.dart';
import 'package:whatsapp_clonee/feature/chats/repositories/chat_repository.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(chatRepository: chatRepository, ref: ref);
});

class ChatTextField extends ConsumerStatefulWidget {
  final String receiverId;
  final ScrollController scrollController;

  const ChatTextField(
      {super.key, required this.receiverId, required this.scrollController});

  @override
  ConsumerState<ChatTextField> createState() => _chatTextField();
}

class _chatTextField extends ConsumerState<ChatTextField> {
  late TextEditingController messageController;
  bool isMessageIconEnabled = false;
  double cardHeight = 0;

  void sendImageMessageFromGallery()async{
    final image = await Navigator.push(context, MaterialPageRoute(builder: (_) => ImagePickerPage()));
    if(image != null){
      sendFileMessage(image, MessageType.image);
      setState(() {
        cardHeight = 0;
      });
    }
  }

  void sendFileMessage(var file, MessageType messageType) async{
    ref
        .read(chatControllerProvider)
        .sendFileMessage(context, file, widget.receiverId, messageType);
    await Future.delayed(Duration(milliseconds: 500));
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      widget.scrollController.animateTo(
          widget.scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut);
    });
  }

  iconWithText(
      {required VoidCallback onPressed,
      required IconData iconData,
      required String text,
      required Color background}) {
    return Column(
      children: [
        CustomIconButton(
          icon: iconData,
          onTap: onPressed,
          background: background,
          minWidth: 50,
          iconColor: Colors.white,
          border: Border.all(
              color: context.theme.grayColor!.withOpacity(.2), width: 1),
        ),
        SizedBox(height: 5),
        Text(
          text,
          style: TextStyle(color: context.theme.grayColor),
        )
      ],
    );
  }

  void sendTextMessage() async {
    if (isMessageIconEnabled) {
      ref.read(chatControllerProvider).sendTextMessage(
          context: context,
          textMessage: messageController.text,
          receiverId: widget.receiverId);
      messageController.clear();
    }
    await Future.delayed(Duration(milliseconds: 100));
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      widget.scrollController.animateTo(
          widget.scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut);
    });
  }

  @override
  void initState() {
    messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 200),
          height: cardHeight,
          width: double.maxFinite,
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: context.theme.receiverChatCardBg,
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      iconWithText(
                          onPressed: () {},
                          iconData: Icons.file_open,
                          text: 'Document',
                          background: Color(0xFF7F66FE)),
                      iconWithText(
                          onPressed: () {},
                          iconData: Icons.camera_alt_rounded,
                          text: 'Camera',
                          background: Color(0xFFFE2E74)),
                      iconWithText(
                          onPressed: sendImageMessageFromGallery,
                          iconData: Icons.photo,
                          text: 'Gallery',
                          background: Color(0xFFC861F9))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      iconWithText(
                          onPressed: () {},
                          iconData: Icons.headphones,
                          text: 'Audio',
                          background: Color(0xFFF96533)),
                      iconWithText(
                          onPressed: () {},
                          iconData: Icons.location_on_rounded,
                          text: 'Location',
                          background: Color(0xFF1FA855)),
                      iconWithText(
                          onPressed: () {},
                          iconData: Icons.person,
                          text: 'Contact',
                          background: Color(0xFF009DE1))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(5),
          height: 52,
          child: Row(
            children: [
              Expanded(
                  child: TextFormField(
                controller: messageController,
                onChanged: (value) {
                  value.isEmpty
                      ? setState(() {
                          isMessageIconEnabled = false;
                        })
                      : setState(() {
                          isMessageIconEnabled = true;
                        });
                },
                decoration: InputDecoration(
                    hintText: "Message",
                    hintStyle: TextStyle(
                        color: context.theme.grayColor,
                        fontSize: 18,
                        height: 3.3),
                    fillColor: context.theme.chatTextFieldBg,
                    filled: true,
                    isDense: true,
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(style: BorderStyle.none, width: 0),
                        borderRadius: BorderRadius.circular(30)),
                    prefixIcon: Material(
                      color: Colors.transparent,
                      child: CustomIconButton(
                        icon: Icons.emoji_emotions_outlined,
                        onTap: () {},
                        iconColor: context.theme.grayColor,
                      ),
                    ),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomIconButton(
                          icon: cardHeight == 0
                              ? Icons.attachment_rounded
                              : Icons.close,
                          onTap: () {
                            setState(() {
                              cardHeight == 0
                                  ? cardHeight = 220.0
                                  : cardHeight = 0;
                            });
                          },
                          iconColor: Theme.of(context).listTileTheme.iconColor,
                        ),
                        CustomIconButton(
                          icon: Icons.camera_alt_rounded,
                          onTap: () {},
                          iconColor: Theme.of(context).listTileTheme.iconColor,
                        ),
                      ],
                    )),
              )),
              SizedBox(width: 5),
              CustomIconButton(
                icon: isMessageIconEnabled
                    ? Icons.send_sharp
                    : Icons.mic_none_rounded,
                onTap: sendTextMessage,
                background: Coloors.greenDark,
                iconColor: Colors.white,
              )
            ],
          ),
        ),
      ],
    );
  }
}
