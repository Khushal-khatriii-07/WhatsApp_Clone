import 'package:flutter/cupertino.dart';
import 'package:whatsapp_clonee/Common/enum/message_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clonee/Common/Model/last_message_model.dart';
import 'package:whatsapp_clonee/Common/Model/message_model.dart';
import 'package:whatsapp_clonee/feature/auth/controller/auth_controller.dart';
import 'package:whatsapp_clonee/feature/chats/repositories/chat_repository.dart';

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;

  ChatController({required this.chatRepository, required this.ref});

  void sendFileMessage(
      BuildContext context,
      var file,
      String receiverId,
      MessageType messageType) {
    ref.read(userInfoAuthProvider).whenData((senderData) {
      return chatRepository.sendFileMessage(
          file: file,
          context: context,
          receiverId: receiverId,
          senderData: senderData!,
          ref: ref,
          messageType: messageType
      );
    });
  }

  Stream<List<MessageModel>> getAllOneToOneMessage(String receiverId) {
    return chatRepository.getAllOneToOneMessage(receiverId);
  }

  Stream<List<LastMessageModel>> getAllLastMessageList() {
    return chatRepository.getAllLastMessageList();
  }

  void sendTextMessage(
      {required BuildContext context,
      required String textMessage,
      required String receiverId}) {
    ref.read(userInfoAuthProvider).whenData((value) =>
        chatRepository.sendTextMessage(
            context: context,
            senderData: value!,
            receiverId: receiverId,
            textMessage: textMessage));
  }
}
