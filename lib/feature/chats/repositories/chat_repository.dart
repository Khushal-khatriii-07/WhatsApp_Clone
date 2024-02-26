import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp_clonee/Common/Model/last_message_model.dart';
import 'package:whatsapp_clonee/Common/Model/message_model.dart';
import 'package:whatsapp_clonee/Common/Model/user_model.dart';
import 'package:whatsapp_clonee/Common/enum/message_type.dart';
import 'package:whatsapp_clonee/Common/helper/show_alert_box.dart';
import 'package:whatsapp_clonee/Common/repository/firebase_storage_repository.dart';

final chatRepositoryProvider = Provider((ref) {
  return ChatRepository(
      firebaseFirestore: FirebaseFirestore.instance,
      firebaseAuth: FirebaseAuth.instance);
});

class ChatRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  ChatRepository({required this.firebaseFirestore, required this.firebaseAuth});

  void sendFileMessage({
    required var file,
    required BuildContext context,
    required String receiverId,
    required UserModel senderData,
    required Ref ref,
    required MessageType messageType,
  }) async {
    try {
      final timeSent = DateTime.now();
      final messageId = Uuid().v1();
      final imageUrl = await ref
          .read(firebaseStorageRepositoryProvider)
          .storeFileToFirebase(
              'chats/${messageType.type}/${senderData.userId}/$receiverId/$messageId',
              file);
      final userMap = await firebaseFirestore.collection('user').doc(receiverId).get();
      final receiverUserData = UserModel.fromMap(userMap.data()!);
      String lastMessage;
      switch(messageType){
        case MessageType.image:
          lastMessage = 'Photo message';
          break;
        case MessageType.audio:
          lastMessage = 'Voice message';
          break;
        case MessageType.video:
          lastMessage = 'Video message';
          break;
        case MessageType.gif:
          lastMessage = 'GIF message';
          break;
        default:
          lastMessage = 'GIF message';
          break;

      }
      saveToMessageCollection(receiverId: receiverId, textMessage: imageUrl, timeSent: timeSent, textMessageId: messageId, senderUserName: senderData.userName, receiverUserName: receiverUserData.userName, messageType: messageType);
      saveAsLastMessage(senderUserData: senderData, receiverUserData: receiverUserData, lastMessage: lastMessage, timeSent: timeSent, receiverId: receiverId);

    } catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }

  Stream<List<MessageModel>> getAllOneToOneMessage(String receiverId) {
    return firebaseFirestore
        .collection('user')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      List<MessageModel> messages = [];
      for (var message in event.docs) {
        messages.add(MessageModel.fromMap(message.data()));
      }
      return messages;
    });
  }

  Stream<List<LastMessageModel>> getAllLastMessageList() {
    return firebaseFirestore
        .collection('user')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .asyncMap((event) async {
      List<LastMessageModel> contacts = [];
      for (var document in event.docs) {
        final lastMessage = LastMessageModel.fromMap(document.data());
        final userData = await firebaseFirestore
            .collection('user')
            .doc(lastMessage.contactId)
            .get();
        final user = UserModel.fromMap(userData.data()!);
        contacts.add(LastMessageModel(
            userName: user.userName,
            profileImageUrl: user.profileImageUrl,
            contactId: lastMessage.contactId,
            timeSent: lastMessage.timeSent,
            lastMessage: lastMessage.lastMessage));
      }
      return contacts;
    });
  }

  void sendTextMessage(
      {required BuildContext context,
      required UserModel senderData,
      required String receiverId,
      required String textMessage}) async {
    try {
      final timeSent = DateTime.now();
      final receiverDataMap =
          await firebaseFirestore.collection('user').doc(receiverId).get();
      final receiverData = UserModel.fromMap(receiverDataMap.data()!);
      final textMessageId = const Uuid().v1();

      saveToMessageCollection(
          receiverId: receiverId,
          textMessage: textMessage,
          timeSent: timeSent,
          textMessageId: textMessageId,
          senderUserName: senderData.userName,
          receiverUserName: receiverData.userName,
          messageType: MessageType.text);

      saveAsLastMessage(
          senderUserData: senderData,
          receiverUserData: receiverData,
          lastMessage: textMessage,
          timeSent: timeSent,
          receiverId: receiverId);
    } catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }

  void saveToMessageCollection(
      {required String receiverId,
      required String textMessage,
      required DateTime timeSent,
      required String textMessageId,
      required String senderUserName,
      required String receiverUserName,
      required MessageType messageType}) async {
    final message = MessageModel(
        senderId: firebaseAuth.currentUser!.uid,
        receiverId: receiverId,
        textMessage: textMessage,
        type: messageType,
        timeSent: timeSent,
        messageId: textMessageId,
        isSeen: false);

    await firebaseFirestore
        .collection("user")
        .doc(firebaseAuth.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .doc(textMessageId)
        .set(message.toMap());

    await firebaseFirestore
        .collection("user")
        .doc(receiverId)
        .collection('chats')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('messages')
        .doc(textMessageId)
        .set(message.toMap());
  }

  void saveAsLastMessage({
    required UserModel senderUserData,
    required UserModel receiverUserData,
    required String lastMessage,
    required DateTime timeSent,
    required String receiverId,
  }) async {
    final receiverLastMessage = LastMessageModel(
        userName: senderUserData.userName,
        profileImageUrl: senderUserData.profileImageUrl,
        contactId: senderUserData.userId,
        timeSent: timeSent,
        lastMessage: lastMessage);

    await firebaseFirestore
        .collection("user")
        .doc(receiverId)
        .collection('chats')
        .doc(firebaseAuth.currentUser!.uid)
        .set(receiverLastMessage.toMap());

    final senderLastMessage = LastMessageModel(
        userName: receiverUserData.userName,
        profileImageUrl: receiverUserData.profileImageUrl,
        contactId: receiverUserData.userId,
        timeSent: timeSent,
        lastMessage: lastMessage);

    await firebaseFirestore
        .collection("user")
        .doc(firebaseAuth.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .set(senderLastMessage.toMap());
  }
}
