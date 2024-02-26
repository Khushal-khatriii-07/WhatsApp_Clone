import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:whatsapp_clonee/Common/Extension/customThemeExtension.dart';
import 'package:whatsapp_clonee/Common/widgets/custom_icon_button.dart';

class ImagePickerPage extends StatefulWidget{
  @override
  State<ImagePickerPage> createState() => _imagePickerPage();
}

class _imagePickerPage extends State<ImagePickerPage>{

  List<Widget> imageList = [];
  int currentPage = 0;
  int? lastPage;

  handleScrollEvent(ScrollNotification scroll){
    if(scroll.metrics.pixels / scroll.metrics.maxScrollExtent <= .33) return;
    if(currentPage == lastPage) return;
    fetchAllImages();
  }
  fetchAllImages() async{
    lastPage = currentPage;
    final permission = await PhotoManager.requestPermissionExtend();
    if(!permission.isAuth) return PhotoManager.openSetting();
    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      onlyAll: true
    );
    List<AssetEntity> photos = await albums[0].getAssetListPaged(
        page: currentPage,
        size: 24
    );

    List<Widget> temp = [];

    for(var asset in photos){
      temp.add(
        FutureBuilder(
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.done){
                return ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: InkWell(
                    onTap: () => Navigator.pop(context, snapshot.data),
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: context.theme.grayColor!.withOpacity(0.3),
                          width: 1,
                        ),
                        image: DecorationImage(
                            image: MemoryImage(snapshot.data as Uint8List),
                            fit: BoxFit.cover
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox();
            }, future: asset.thumbnailDataWithSize(
                   const ThumbnailSize(200, 200)
        ),)
      );
    }
    setState(() {
      imageList.addAll(temp);
      currentPage++;
    });
  }

  @override
  void initState() {
    fetchAllImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        leading: CustomIconButton(icon: Icons.arrow_back, onTap: () => Navigator.of(context).pop(),),
        title: const Text(
          'Whatsapp',
          style: TextStyle(),
        ),
        actions: [
          CustomIconButton(icon: Icons.more_vert, onTap: (){})
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3),
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scroll){
            handleScrollEvent(scroll);
            return true;
          },
          child: GridView.builder(
            itemCount: imageList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), itemBuilder: (_, index){
            return imageList[index];
          }),
        ),
      ),
    );
  }
}