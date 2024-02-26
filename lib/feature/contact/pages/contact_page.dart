import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_clonee/Common/Extension/customThemeExtension.dart';
import 'package:whatsapp_clonee/Common/Model/user_model.dart';
import 'package:whatsapp_clonee/Common/routes/routes.dart';
import 'package:whatsapp_clonee/Common/utils/colors.dart';
import 'package:whatsapp_clonee/Common/widgets/custom_icon_button.dart';
import 'package:whatsapp_clonee/feature/contact/Widgets/contact_card.dart';
import 'package:whatsapp_clonee/feature/contact/controller/contacts_controllers.dart';
import 'package:whatsapp_clonee/feature/contact/repository/contact_repository.dart';

class ContactPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select contact',
              style: TextStyle(fontSize: 17, color: Colors.white),
            ),
            ref.watch(contactControllerProvider).when(data: (allContacts) {
              return Text(
                '${allContacts[0].length} Contact${allContacts[0].length == 1 ? '' : 's'}',
                style: TextStyle(fontSize: 12, color: Colors.white),
              );
            }, error: (e, t) {
              return const SizedBox();
            }, loading: () {
              return Text(
                'counting',
                style: TextStyle(fontSize: 12, color: Colors.white),
              );
            }),
          ],
        ),
        actions: [
          CustomIconButton(icon: Icons.search, onTap: () {}),
          CustomIconButton(icon: Icons.more_vert, onTap: () {})
        ],
      ),
      body: ref.watch(contactControllerProvider).when(data: (allContacts) {
        return ListView.builder(
            itemCount: allContacts[0].length + allContacts[1].length,
            itemBuilder: (context, index) {
              late UserModel firebaseContacts;
              late UserModel phoneContacts;

              if (index < allContacts[0].length) {
                firebaseContacts = allContacts[0][index];
              } else {
                phoneContacts = allContacts[1][index - allContacts[0].length];
              }

              return index < allContacts[0].length
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index == 0)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              myListTile(leading: Icons.group, text: 'New groups'),
                              myListTile(leading: Icons.contacts, text: 'New contacts', trailing: Icons.qr_code),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Text(
                                  'Contact on Whatsapp',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: context.theme.grayColor),
                                ),
                              ),
                            ],
                          ),
                        ContactCard(
                          contactSource: firebaseContacts,
                          onTap: (){
                            Navigator.of(context).pushNamed(Routes.chat, arguments: firebaseContacts);
                          },
                        )
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index == allContacts[0].length)
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                              'Invite on whatsapp',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: context.theme.grayColor),
                            ),
                          ),
                        ContactCard(
                            contactSource: phoneContacts,
                            onTap: () =>
                                shareSmsLink(phoneContacts.phoneNumber))
                      ],
                    );
            });
      }, error: (e, t) {
        return Container(
          height: 100,
          width: 100,
          child: Text('error occured'),
        );
      }, loading: () {
        return Center(
          child: CircularProgressIndicator(
            color: Coloors.greenDark,
          ),
        );
      }),
    );
  }

  shareSmsLink(String phoneNumber) async {
    Uri sms = Uri.parse(
        "sms:$phoneNumber?body=Let's chat on whatsapp! its fast and secure app we can call each other for free. Get it at https://whatsAppme.com/dl");
    if (await launchUrl(sms)) {
    } else {}
    ;
  }

  ListTile myListTile(
      {required IconData leading, required String text, IconData? trailing}) {
    return ListTile(
      contentPadding: EdgeInsets.only(top: 10, left: 20, right: 10),
      leading: CircleAvatar(
          backgroundColor: Coloors.greenDark,
          radius: 20,
          child: Icon(
            leading,
            color: Colors.white,
          )),
      title: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: Icon(
        trailing,
        color: Colors.white,
      ),
    );
  }
}
