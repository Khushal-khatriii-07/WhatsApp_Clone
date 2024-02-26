import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clonee/Common/Extension/customThemeExtension.dart';
import 'package:whatsapp_clonee/Common/widgets/custom_icon_button.dart';
import 'package:whatsapp_clonee/feature/auth/controller/auth_controller.dart';
import 'package:whatsapp_clonee/feature/auth/widgets/custom_text_field.dart';

class VerificationPage extends ConsumerWidget{
  VerificationPage({super.key, required this.smsCodeId, required this.phoneNumber});
  final String smsCodeId;
  final String phoneNumber;

  void verifySmsCode(
      BuildContext context,
      WidgetRef ref,
      String smsCode,
      ){
    ref.read(authControllerProvider).verifySmsCode(context: context, smsCodeId: smsCodeId, smsCode: smsCode, mounted: true);
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify your number"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [CustomIconButton(icon: Icons.more_vert, onTap: () {})],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: TextStyle(
                          color: context.theme.grayColor, height: 1.2),
                      children: [
                        TextSpan(
                            text:
                                "You've tried to register +2510912345678 before requesting an sms or call with your phone code."),
                        TextSpan(
                            text: " Wrong number?",
                            style: TextStyle(
                              color: context.theme.blueColor,
                            ))
                      ])),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: CustomTextField(
                  keyboardType: TextInputType.number,
                  hintText: '- - -  - - -',
                  textSize: 30,
                  autoFocus: true,
                  onChanged: (value) {
                    if(value.length == 6){
                      return verifySmsCode(context, ref, value);
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Enter 6 digit code",
                    style: TextStyle(color: context.theme.grayColor),
                  )),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.message_outlined, color: context.theme.grayColor),
                  SizedBox(width: 10),
                  Text(
                    "Resend SMS",
                    style: TextStyle(color: context.theme.grayColor),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: context.theme.blueColor!.withOpacity(0.2),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(Icons.phone, color: context.theme.grayColor),
                  SizedBox(width: 10),
                  Text(
                    "Call Me",
                    style: TextStyle(color: context.theme.grayColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
