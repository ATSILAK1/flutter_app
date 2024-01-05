import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_storage_path/flutter_storage_path.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_tutorial/views/widgets/filemodel.dart';


class MediaPicker extends StatefulWidget {
  MediaPicker({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MediaPickerState createState() => _MediaPickerState();
}

class _MediaPickerState extends State<MediaPicker> {
   List<FileModel>? files;
   FileModel? selectedModel;
   String? image;
  @override
  void initState() {
    super.initState();
    Permission.storage.request();
    getImagesPath();
  }

  getImagesPath() async {
      

   
    var imagePath = await StoragePath.imagesPath;
    var images = jsonDecode(imagePath!) as List;
    files = images.map<FileModel>((e) => FileModel.fromJson(e)).toList();
    if (files != null && files!.length > 0)
      setState(() {
        selectedModel = files![0];
        image = files![0].files[0];
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.clear),
                    SizedBox(width: 10),
                    DropdownButtonHideUnderline(
                        child: DropdownButton<FileModel>(
                          value: selectedModel,
                      items: getItems(),
                      onChanged: (FileModel? d) {
                        if(d == null) return ;
                         assert(d.files.isNotEmpty);
                         image = d.files[0];
                         setState(() {
                           selectedModel = d;
                         });
                     },
                     
                    ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Next',
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            ),
            Divider(),
            Container(
                height: MediaQuery.of(context).size.height * 0.45,
                child: image != null
                    ? Image.file(File(image!),
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: MediaQuery.of(context).size.width)
                    : Container()),
            Divider(),
            selectedModel == null || selectedModel!.files.length < 1
                ? Container()
                : Container(
                    height: MediaQuery.of(context).size.height * 0.38,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4),
                        itemBuilder: (_, i) {
                          var file = selectedModel!.files[i];
                          return GestureDetector(
                            child: Image.file(
                              File(file),
                              fit: BoxFit.cover,
                            ),
                            onTap: () {
                              setState(() {
                                image = file;
                              });
                            },
                          );
                        },
                        itemCount: selectedModel!.files.length),
                  )
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<FileModel>> getItems() {
    if(files == null)
      return [];
    return files!
            .map((e) => DropdownMenuItem(
                  child: Text(
                    e.folder,
                    style: TextStyle(color: Colors.black),
                  ),
                  value: e,
                ))
            .toList() ??
        [];
  }
}