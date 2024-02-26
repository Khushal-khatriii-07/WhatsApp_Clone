import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clonee/Common/Extension/customThemeExtension.dart';
import 'package:whatsapp_clonee/Common/Model/user_model.dart';
import 'package:whatsapp_clonee/Common/utils/colors.dart';
import 'package:whatsapp_clonee/Common/widgets/custom_icon_button.dart';
import 'package:whatsapp_clonee/feature/chats/widgets/custom_list_tile.dart';
import 'package:whatsapp_clonee/feature/chats/widgets/custom_text_with_icon.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.profilePageBg,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: SliverPersistentDelegate(user),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Text(
                        user.userName,
                        style: TextStyle(fontSize: 25),
                      ),
                      SizedBox(height: 5),
                      Text(
                        user.phoneNumber,
                        style: TextStyle(
                            fontSize: 18, color: context.theme.grayColor),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWithIcon(
                                icon: Icons.call_rounded, text: "Audio"),
                            CustomTextWithIcon(
                                icon: CupertinoIcons.videocam_fill,
                                text: "Video"),
                            CustomTextWithIcon(
                                icon: Icons.currency_rupee, text: "Pay"),
                            CustomTextWithIcon(
                                icon: Icons.search_rounded, text: "Search"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 15),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 20),
                  title: Text(
                    "Hey there! I am using WhatsApp",
                    style: TextStyle(fontSize: 18),
                  ),
                  subtitle: Text(
                    "2 may 2020",
                    style: TextStyle(color: context.theme.grayColor),
                  ),
                ),
                SizedBox(height: 15),
                CustomListTile(
                  title: "Mute notification",
                  leading: Icons.notifications,
                  trailing: Switch(value: false, onChanged: (value) {}),
                ),
                CustomListTile(
                    title: "Custom notification", leading: Icons.music_note),
                CustomListTile(title: "Media visibility", leading: Icons.image),
                SizedBox(height: 15),
                CustomListTile(
                  title: "Encryption",
                  leading: Icons.lock,
                  subtitle:
                      "Messages and calls are end-to-end encrypted. Tap to verify.",
                ),
                CustomListTile(
                  title: "Disappearing messages",
                  leading: Icons.access_time,
                  subtitle: "Off",
                ),
                CustomListTile(
                    title: "Chat lock",
                    leading: Icons.block,
                    subtitle: "Lock and hide this chat on this device.",
                    trailing: Switch(value: false, onChanged: (value) {})),
                SizedBox(height: 15),
                CustomListTile(
                    title: "Create group with ${user.userName}",
                    leading: Icons.group),
                SizedBox(height: 15),
                CustomListTile(
                  title: "Block ${user.userName}",
                  leading: Icons.block,
                  color: Colors.red,
                ),
                CustomListTile(
                  title: "Report ${user.userName}",
                  leading: Icons.thumb_down,
                  color: Colors.red,
                ),
                SizedBox(height: 15),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SliverPersistentDelegate extends SliverPersistentHeaderDelegate {
  final UserModel user;
  final double maxHeaderHeight = 180;
  final double minHeaderHeight = kToolbarHeight + 35;
  final double maxImageSize = 130;
  final double minImageSize = 40;

  SliverPersistentDelegate(this.user);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final size = MediaQuery.of(context).size;
    final persent = shrinkOffset / (maxHeaderHeight - 35);
    final persent2 = shrinkOffset / (maxHeaderHeight);
    final currentImageSize =
        (maxImageSize * (1 - persent)).clamp(minImageSize, maxImageSize);
    final currentImagePosition = ((size.width / 2 - 65) * (1 - persent))
        .clamp(minImageSize, maxImageSize);
    return Container(
      color: Theme.of(context)
          .appBarTheme
          .backgroundColor!
          .withOpacity(persent * 2 < 1 ? persent : .99),
      child: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).viewPadding.top + 20,
            left: currentImagePosition + 50,
            child: Text(
              user.userName,
              style: TextStyle(
                  fontSize: 18, color: Colors.white.withOpacity(persent2)),
            ),
          ),
          Positioned(
            left: 0,
            top: MediaQuery.of(context).viewPadding.top + 5,
            child: BackButton(
              color: persent2 > .3 ? Colors.white.withOpacity(persent2) : null,
            ),
          ),
          Positioned(
            right: 0,
            top: MediaQuery.of(context).viewPadding.top + 5,
            child: CustomIconButton(
              icon: Icons.more_vert,
              onTap: () {},
              iconColor: persent2 > .3
                  ? Colors.white.withOpacity(persent2)
                  : Theme.of(context).textTheme.bodyText2!.color,
            ),
          ),
          Positioned(
              left: currentImagePosition,
              top: MediaQuery.of(context).viewPadding.top + 5,
              bottom: 0,
              child: Hero(
                tag: 'profile',
                child: Container(
                  width: currentImageSize,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(user.profileImageUrl),
                      )),
                ),
              ))
        ],
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => maxHeaderHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => minHeaderHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
