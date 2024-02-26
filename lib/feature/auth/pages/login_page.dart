import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clonee/Common/Extension/customThemeExtension.dart';
import 'package:whatsapp_clonee/Common/helper/show_alert_box.dart';
import 'package:whatsapp_clonee/Common/utils/colors.dart';
import 'package:whatsapp_clonee/Common/widgets/custom_elevated_button.dart';
import 'package:whatsapp_clonee/Common/widgets/custom_icon_button.dart';
import 'package:whatsapp_clonee/feature/auth/controller/auth_controller.dart';
import 'package:whatsapp_clonee/feature/auth/pages/verification_page.dart';
import 'package:whatsapp_clonee/feature/auth/repository/auth_repository.dart';
import 'package:whatsapp_clonee/feature/auth/widgets/custom_text_field.dart';

class LoginPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<LoginPage> createState() => _loginPageState();
}

class _loginPageState extends ConsumerState<LoginPage> {
  late TextEditingController countryNameController;
  late TextEditingController countryCodeController;
  late TextEditingController phoneNumberController;

  @override
  void initState() {
    countryNameController = TextEditingController(text: 'Ethepia');
    countryCodeController = TextEditingController(text: '251');
    phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    countryCodeController.dispose();
    countryNameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  // TextEditingController phoneController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter your phone number"),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          CustomIconButton(icon: Icons.more_vert, onTap: () {  },),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "WhatsApp will need to verify your phone number",
                    style:
                        TextStyle(color: context.theme.grayColor, height: 1.5),
                    children: [
                      TextSpan(
                          text: " What's my number?",
                          style: TextStyle(color: context.theme.blueColor))
                    ])),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: CustomTextField(
              onTap: showCountryCodePicker,
              readOnly: true,
              controller: countryNameController,
              suffixIcon: Icon(
                Icons.arrow_drop_down,
                color: Coloors.greenDark,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              children: [
                SizedBox(
                  width: 70,
                  child: CustomTextField(
                    onTap: showCountryCodePicker,
                    readOnly: true,
                    prefixText: '+',
                    controller: countryCodeController,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                    child: CustomTextField(
                      controller: phoneNumberController,
                      textAlign: TextAlign.left,
                      hintText: 'phone number',
                      keyboardType: TextInputType.phone,
                    )
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Text("Carrier charges may apply", style: TextStyle(color: context.theme.grayColor),),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButton(
        onPress: sendCodeToPhone,
        text: "NEXT",
        buttonWidth: 90,
      ),
    );
  }

  showCountryCodePicker() {
    showCountryPicker(
        context: context,
        showPhoneCode: true,
        favorite: ['IN'],
        countryListTheme: CountryListThemeData(
          bottomSheetHeight: 600,
          backgroundColor: Theme.of(context).backgroundColor,
          flagSize: 22,
          borderRadius: BorderRadius.circular(20),
          textStyle: TextStyle(color: context.theme.grayColor),
          inputDecoration: InputDecoration(
            labelStyle: TextStyle(color: context.theme.grayColor),
            prefixIcon: Icon(Icons.language, color: Coloors.greenDark),
            hintText: "Search country code or name",
            // hintStyle: TextStyle(color: Coloors.grayDark),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: context.theme.grayColor!.withOpacity(0.2),
              )
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Coloors.greenDark,
                )
            ),
          )
        ),
        onSelect: (country) {
          countryNameController.text = country.name;
          countryCodeController.text = country.phoneCode;
        });
  }

  sendCodeToPhone() {
    final phoneNumber = phoneNumberController.text;
    final countryName = countryNameController.text;
    final countryCode = countryCodeController.text;

    if(phoneNumber.isEmpty){
      showAlertDialog(context: context, message: "please enter phone number");
    }else if(phoneNumber.length < 9){
      showAlertDialog(context: context, message: "The phone number you entered is too short for the country $countryName.\n\nInclude your area if You've not entered");
    }else if(phoneNumber.length > 10){
      return showAlertDialog(context: context, message: "The phone number you entered is too large for the country $countryName");
    }

    //request a verification code
    ref.read(authControllerProvider).sendSmsCode(context: context, phoneNumber: '+$countryCode$phoneNumber');
  }
}

