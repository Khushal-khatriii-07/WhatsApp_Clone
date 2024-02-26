import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clonee/Common/Model/user_model.dart';
import 'package:whatsapp_clonee/feature/auth/repository/auth_repository.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository, ref: ref);
});

final userInfoAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getCurrentUserInfo();
});

class AuthController{
  final AuthRepository authRepository;
  final ProviderRef ref;

  Future<UserModel?> getCurrentUserInfo()async{
    UserModel? user = await authRepository.getCurrentUserInfo();
    return user;
  }

  void updateUserPresence(){
    return authRepository.updateUserPresence();
  }

  void saveUserInfoToFirebase(
      {required String userName,
        required var profileImage,
        required BuildContext context,
        required bool mounted})
  {
    authRepository.saveUserInfoToFirebase(
        userName: userName,
        profileImage: profileImage,
        ref: ref,
        context: context,
        mounted: mounted);
  }

  void verifySmsCode({
    required BuildContext context,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
  }){
    authRepository.verifySmsCode(context: context, smsCodeId: smsCodeId, smsCode: smsCode, mounted: mounted);
  }
  
  AuthController({required this.ref, required this.authRepository});

  void sendSmsCode({required BuildContext context, required String phoneNumber}){
    authRepository.sendSmsCode(
        context: context, phoneNumber: phoneNumber
    );
  }

}