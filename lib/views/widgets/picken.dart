import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

class MediaGrid extends StatefulWidget {
  @override
  _MediaGridState createState() => _MediaGridState();
}
class _MediaGridState extends State<MediaGrid> {
  List<AssetEntity> _mediaList = [];
  @override
  void initState() {
    super.initState();
    _fetchNewMedia();
  }
_fetchNewMedia() async {
    var result = await PhotoManager.requestPermissionExtend();
    if (result == true) {
      // success
//load the album list
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(onlyAll: true);
      print("album" + albums.toString());
      List<AssetEntity> media = await albums[0].getAssetListPaged(page: 0,size: 20);
      print(media);
setState(() {
        _mediaList = media;
      });
    } else {
      PhotoManager.openSetting();
      // fail
      /// if result is fail, you can call `PhotoManager.openSetting();`  to open android/ios applicaton's setting to get permission
    }
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: GridView.builder(
          itemCount: _mediaList.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index) {
            return FutureBuilder(
              future: _mediaList[index].thumbnailDataWithSize(ThumbnailSize.square(200)),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Image.memory(
                    
                    snapshot.data as Uint8List,
                    fit: BoxFit.fill,
                  );
                }
      return Container();
              },
            );
          }),
    );
  }
}