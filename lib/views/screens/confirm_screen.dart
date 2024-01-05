import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_tutorial/controllers/upload_video_controller.dart';
import 'package:tiktok_tutorial/views/widgets/text_input_field.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;
  const ConfirmScreen({
    Key? key,
    required this.videoFile,
    required this.videoPath,
  }) : super(key: key);

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller;
  TextEditingController _songController = TextEditingController();
  TextEditingController _captionController = TextEditingController();

  UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());

  @override
  void initState() {
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF161616),
     
      body: SingleChildScrollView(
        
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              height: MediaQuery.of(context).size.height / 1.5 ,
              child: VideoPlayer(controller),
            ),
            const SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 1)),
                    margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                    width: MediaQuery.of(context).size.width - 150,
                    child: TextField(
                      
                      controller: _captionController,
                      maxLength: 200,
                      maxLines: 5,
                      
                      decoration:  
                      InputDecoration(hintText: "Description...",
                      fillColor: Color.fromRGBO(0,0, 0, 1),
                      filled: true,
                      contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10)
                      ,border: InputBorder.none
                      
                       
                      
                    
                      
                    )
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  IconButton(
                      onPressed: () => uploadVideoController.uploadVideo(
                          _songController.text,
                          _captionController.text,
                          widget.videoPath),
                      icon: Image.asset('assets/img/AddVideoButton.png',),
                      
                      
                      )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
