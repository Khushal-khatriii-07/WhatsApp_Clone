import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clonee/Common/Extension/customThemeExtension.dart';
import 'package:whatsapp_clonee/Common/Model/user_model.dart';
import 'package:whatsapp_clonee/Common/utils/colors.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.contactSource, required this.onTap,
  });

  final UserModel contactSource;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.only(left: 20, right: 10),
      dense: true,
      leading: CircleAvatar(
        backgroundColor:
        context.theme.grayColor!.withOpacity(0.3),
        radius: 20,
        backgroundImage: contactSource
            .profileImageUrl.isNotEmpty
            ? CachedNetworkImageProvider(contactSource.profileImageUrl)
            : null,
        child: contactSource.profileImageUrl.isEmpty
            ? const Icon(Icons.person, color: Colors.white,)
            : null,
      ),
      title: Text(
        contactSource.userName,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500),
      ),
      subtitle: contactSource.profileImageUrl.isEmpty ? null : Text(
        "Hay there! I'm using Whatsapp",
        style: TextStyle(
            color: context.theme.grayColor,
            fontWeight: FontWeight.w600),
      ),
      trailing: contactSource.profileImageUrl.isEmpty ? TextButton(
        onPressed: onTap,
        child: Text('INVITE', style: TextStyle(color: Coloors.greenDark),),
      ) : null,
    );
  }
}