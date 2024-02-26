import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clonee/Common/Extension/customThemeExtension.dart';
import 'package:whatsapp_clonee/Common/Model/message_model.dart';
import 'package:whatsapp_clonee/Common/enum/message_type.dart' as myMessageType;

class MessageCard extends StatelessWidget {
  const MessageCard({
    super.key,
    required this.isSender,
    required this.haveNip,
    required this.message,
  });

  final bool isSender;
  final bool haveNip;
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        margin: EdgeInsets.only(
          top: 1,
          bottom: 2,
          left: isSender
              ? 80
              : haveNip
                  ? 10
                  : 15,
          right: isSender
              ? haveNip
                  ? 10
                  : 15
              : 80,
        ),
        child: ClipPath(
          clipper: haveNip
              ? UpperNipMessageClipperTwo(
                  isSender ? MessageType.send : MessageType.receive,
                  nipWidth: 8,
                  nipHeight: 10,
                  bubbleRadius: haveNip ? 12 : 0,
                )
              : null,
          child: Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: isSender
                          ? context.theme.senderChatCardBg
                          : context.theme.receiverChatCardBg,
                      borderRadius: haveNip ? null : BorderRadius.circular(12),
                      boxShadow: const [BoxShadow(color: Colors.black38)]),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: message.type == myMessageType.MessageType.image
                        ? Padding(
                            padding: const EdgeInsets.only(
                                right: 3, left: 3, top: 3),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image(
                                image: CachedNetworkImageProvider(
                                    message.textMessage),
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(
                            top: 3,
                            bottom: 3,
                            left: isSender ? 10 : 15,
                            right: isSender ? 15  : 10),
                            child: Text(
                              "${message.textMessage}         ",
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                  )),
              Positioned(
                  bottom: message.type == myMessageType.MessageType.text ? 8 : 4,
                  right: message.type == myMessageType.MessageType.text ? isSender ? 15 :10 :4,
                  child: message.type == myMessageType.MessageType.text ? Text(
                    DateFormat.Hm().format(message.timeSent),
                    style: TextStyle(
                        fontSize: 12,
                        color: context.theme.grayColor,
                        fontWeight: FontWeight.w500),
                  ):Container(
                    padding: EdgeInsets.only(left: 90, right: 10, bottom: 8, top: 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment(0,-1),
                          end: Alignment(1,1),
                          colors: [
                        context.theme.receiverChatCardBg!.withOpacity(0),
                        context.theme.chatPageBgColor!.withOpacity(.2),
                      ]),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(300),
                        bottomRight: Radius.circular(100)
                      )
                    ),
                    child: Text(
                      DateFormat.Hm().format(message.timeSent),
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
              ),
            ],
          ),
        ));
  }
}
