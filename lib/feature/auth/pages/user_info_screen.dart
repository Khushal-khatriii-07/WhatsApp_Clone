import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clonee/Common/Extension/customThemeExtension.dart';
import 'package:whatsapp_clonee/Common/helper/show_alert_box.dart';
import 'package:whatsapp_clonee/Common/utils/colors.dart';
import 'package:whatsapp_clonee/Common/widgets/custom_elevated_button.dart';
import 'package:whatsapp_clonee/Common/widgets/custom_icon_button.dart';
import 'package:whatsapp_clonee/Common/widgets/short_HBar.dart';
import 'package:whatsapp_clonee/feature/auth/controller/auth_controller.dart';
import 'package:whatsapp_clonee/feature/auth/pages/image_picker.dart';
import 'package:whatsapp_clonee/feature/auth/widgets/custom_text_field.dart';

class UserInformation extends ConsumerStatefulWidget {
  UserInformation({super.key, required this.profileImageUrl});
  final String? profileImageUrl;

  @override
  ConsumerState<UserInformation> createState() => _UserInformation();
}

class _UserInformation extends ConsumerState<UserInformation> {
  File? imageCamera;
  Uint8List? imageGallery;

  late TextEditingController userNameController;

  saveUserDataToFirebase(){
    String userName = userNameController.text;

    if(userName.isEmpty){
      showAlertDialog(context: context, message: 'Please enter user name');
    }
    else if(userName.length <3 || userName.length>20){
      showAlertDialog(context: context, message: 'A user name should be between 3 to 20 character');
    }

    ref.read(authControllerProvider).saveUserInfoToFirebase(
        userName: userName,
        profileImage: imageCamera ?? imageGallery ?? widget.profileImageUrl ?? '',
        context: context,
        mounted: mounted);
  }

  @override
  void initState() {
    userNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text("Profile info"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              'Please provide your name and an optional profile photo',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.theme.grayColor,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: imagePickerTypeBottomSheet,
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.theme.photoIconBgColor,
                  border: Border.all(
                    color: imageCamera == null && imageGallery == null
                        ? Colors.transparent
                        : context.theme.grayColor!.withOpacity(0.4),
                  ),
                  image: imageCamera != null || imageGallery != null || widget.profileImageUrl != null
                      ? DecorationImage(
                          fit: BoxFit.cover,
                          image: imageGallery != null
                              ? MemoryImage(imageGallery!) as ImageProvider
                              : widget.profileImageUrl != null ? NetworkImage(widget.profileImageUrl!) : FileImage(imageCamera!) as ImageProvider,
                        )
                      : null,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 3, right: 3),
                  child: Icon(
                    Icons.add_a_photo,
                    color: imageCamera == null && imageGallery == null && widget.profileImageUrl == null ? context.theme.photoIconColor : Colors.transparent,
                    size: 40,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                 Expanded(
                  child: CustomTextField(
                    controller: userNameController,
                    hintText: 'Type your name here',
                    textAlign: TextAlign.left,
                    autoFocus: true,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.emoji_emotions_outlined,
                  color: context.theme.photoIconColor,
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButton(
        onPress: saveUserDataToFirebase,
        text: 'Next',
        buttonWidth: 90,
      ),
    );
  }

  imagePickerTypeBottomSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ShortHBar(),
              const SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 20),
                  Text("Profile Photo",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  Spacer(),
                  CustomIconButton(
                      icon: Icons.close, onTap: () => Navigator.pop(context)),
                  SizedBox(width: 20)
                ],
              ),
              Divider(
                color: context.theme.blueColor!.withOpacity(0.2),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  imagePickerIcon(
                      onTap: pickImageFromCamera,
                      iconData: Icons.camera_alt_rounded,
                      text: 'Camera'),
                  SizedBox(width: 40),
                  imagePickerIcon(
                      onTap: () async {
                        Navigator.pop(context);
                        final image = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImagePickerPage()));
                        if (image == null) return;
                        setState(() {
                          imageGallery = image;
                          imageCamera = null;
                        });
                      },
                      iconData: Icons.photo_camera_back_rounded,
                      text: 'Gallery'),
                ],
              ),
              const SizedBox(height: 10)
            ],
          );
        });
  }

  imagePickerIcon(
      {required VoidCallback onTap,
      required IconData iconData,
      required String text}) {
    return Column(
      children: [
        CustomIconButton(
          icon: iconData,
          onTap: onTap,
          iconColor: Coloors.greenDark,
          border: Border.all(
            color: context.theme.grayColor!.withOpacity(0.2),
          ),
        ),
        SizedBox(height: 5),
        Text(text, style: TextStyle(color: context.theme.grayColor))
      ],
    );
  }

  pickImageFromCamera()async{
    Navigator.of(context).pop();
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      setState(() {
        imageCamera = File(image!.path);
        imageGallery = null;
      });
    }catch(e){
      showAlertDialog(context: context, message: e.toString());
    }
  }
}
