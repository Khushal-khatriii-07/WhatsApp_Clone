// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clonee/Common/Model/user_model.dart';
import 'package:whatsapp_clonee/Common/helper/show_alert_box.dart';
import 'package:whatsapp_clonee/Common/helper/show_loading_dialog.dart';
import 'package:whatsapp_clonee/Common/repository/firebase_storage_repository.dart';
import 'package:whatsapp_clonee/Common/routes/routes.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(
      firebaseAuth: FirebaseAuth.instance,
      firebaseFirestore: FirebaseFirestore.instance,
      realtime : FirebaseDatabase.instance
  );
});

class AuthRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseDatabase realtime;

  AuthRepository({required this.firebaseAuth, required this.firebaseFirestore, required this.realtime});

  void updateUserPresence()async{
    Map<String, dynamic> online = {
      'active': true,
      'lastSeen': DateTime.now().millisecondsSinceEpoch
    };
    Map<String, dynamic> offline = {
      'active': false,
      'lastSeen': DateTime.now().millisecondsSinceEpoch,
    };

    final connectedRef = realtime.ref('.info/connected');
    connectedRef.onValue.listen((event) async{
      final isConnected = event.snapshot.value as bool? ?? false;
      if(isConnected){
        await realtime.ref().child(firebaseAuth.currentUser!.uid).update(online);
      }else{
        realtime.ref().child(firebaseAuth.currentUser!.uid).onDisconnect().update(offline);
      }
    });
  }

  Future<UserModel?> getCurrentUserInfo() async{
    UserModel? user;
    final userInfo = await firebaseFirestore.collection('user').doc(firebaseAuth.currentUser?.uid).get();
    if(userInfo.data()== null) return user;
    user = UserModel.fromMap(userInfo.data()!);
    return user;
  }

  void saveUserInfoToFirebase(
      {required String userName,
      required var profileImage,
      required ProviderRef ref,
      required BuildContext context,
      required bool mounted}) async {
    try {
      showLoadingDialog(context: context, message: 'Saving user info....');
      String userId = firebaseAuth.currentUser!.uid;
      String profileImageUrl = profileImage is String ? profileImage : '';
      if (profileImage != null && profileImage is! String) {
        profileImageUrl = await ref
            .read(firebaseStorageRepositoryProvider)
            .storeFileToFirebase('profileImage/$userId', profileImage);
      }
      UserModel user = UserModel(
          userName: userName,
          userId: userId,
          profileImageUrl: profileImageUrl,
          active: true,
          phoneNumber: firebaseAuth.currentUser!.phoneNumber!,
          groupId: [], lastSeen: DateTime.now().millisecondsSinceEpoch);

      await firebaseFirestore.collection('user').doc(userId).set(user.toMap());
      if(!mounted) return;

      Navigator.of(context).pushNamedAndRemoveUntil(Routes.home, (route) => false);

    } catch (e) {
      Navigator.pop(context);
      showAlertDialog(context: context, message: e.toString());
    }
  }

  void verifySmsCode({
    required BuildContext context,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
  }) async {
    try {
      showLoadingDialog(context: context, message: 'Verifying code....');
      final credential = PhoneAuthProvider.credential(
          verificationId: smsCodeId, smsCode: smsCode);
      await firebaseAuth.signInWithCredential(credential);
      UserModel? user = await getCurrentUserInfo();
      if (!mounted) return;
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Routes.userInfo, (route) => false, arguments: user?.profileImageUrl );
    } on FirebaseAuthException catch (exp) {
      Navigator.pop(context);
      showAlertDialog(context: context, message: exp.toString());
    }
  }

  void sendSmsCode(
      {required BuildContext context, required String phoneNumber}) async {
    try {
      showLoadingDialog(context: context, message: 'Sending a verification code to $phoneNumber');
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (exp) {
          showAlertDialog(context: context, message: exp.toString());
        },
        codeSent: (smsCodeId, resendSmsCodeId) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.verification, (route) => false,
              arguments: {
                'phoneNumber': phoneNumber,
                'smsCodeId': smsCodeId,
              });
        },
        codeAutoRetrievalTimeout: (String smsCodeId) {},
      );
    } on FirebaseAuthException catch (exp) {
      Navigator.pop(context);
      showAlertDialog(context: context, message: exp.toString());
    }
  }
}
