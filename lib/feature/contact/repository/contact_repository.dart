import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clonee/Common/Model/user_model.dart';

final ContactsRepositoryProvider = Provider((ref) {
  return ContactsRepository(firebaseFirestore: FirebaseFirestore.instance);
});

class ContactsRepository{
  final FirebaseFirestore firebaseFirestore;

  ContactsRepository({required this.firebaseFirestore});

  Future<List<List>> getAllContacts()async{
    List<UserModel> firebaseContacts = [];
    List<UserModel> phoneContacts = [];

    try{
      if(await FlutterContacts.requestPermission()){
        final userCollection = await firebaseFirestore.collection('user').get();
        final allContactsInThePhone = await FlutterContacts.getContacts(withProperties: true);
        bool isContactFound = false;
        for(var contact in allContactsInThePhone){
          for(var firebaseContactData in userCollection.docs){
            var firebaseContact = UserModel.fromMap(firebaseContactData.data());
            if(contact.phones[0].number.replaceAll(' ', '') == firebaseContact.phoneNumber){
              firebaseContacts.add(firebaseContact);
              isContactFound = true;
              break;
            }
          }
          if(!isContactFound){
            phoneContacts.add(UserModel(
                userName: contact.displayName,
                userId: '',
                profileImageUrl: '',
                active: true,
                phoneNumber: contact.phones[0].number.replaceAll(' ', ''),
                groupId: [], lastSeen: 0),
            );
          }
          isContactFound = false;
        }
      }
    }catch(e){
      log(e.toString());
    }
    return [firebaseContacts, phoneContacts];
  }
}