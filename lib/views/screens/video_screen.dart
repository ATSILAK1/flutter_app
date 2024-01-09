// ignore_for_file: prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
//import 'package:tiktok_tutorial/constants.dart';
import 'package:tiktok_tutorial/controllers/video_controller.dart';
import 'package:tiktok_tutorial/views/screens/comment_screen.dart';
import 'package:tiktok_tutorial/views/widgets/comment_Widget.dart';
//import 'package:tiktok_tutorial/views/widgets/circle_animation.dart';
import 'package:tiktok_tutorial/views/widgets/video_player_iten.dart';
//import 'package:video_player/video_player.dart';
import 'package:get/get.dart';
//import 'package:tiktok_tutorial/views/widgets/my_flutter_app_icons.dart';

class VideoScreen extends StatefulWidget {
  VideoScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final VideoController videoController = Get.put(VideoController());
  bool flower = false;
  int isVisible = 2;

  buildProfile(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(children: [
        Positioned(
          left: 5,
          child: Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image(
                image: NetworkImage(profilePhoto),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
      ]),
    );
  }

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(11),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.grey,
                      Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(profilePhoto),
                  fit: BoxFit.cover,
                ),
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Obx(() {
        return PageView.builder(
          itemCount: videoController.videoList.length,
          controller: PageController(initialPage: 0, viewportFraction: 1),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final data = videoController.videoList[index];
            return Stack(
              children: [
                 VideoPlayerItem(
                    videoUrl: data.videoUrl,
                     isCommentOpen: isVisible == 2,
                  ),
                //Container(width: size.width,
                //          height: size.height,
                //  child: Image.asset("assets/img/images.jpg"),),
                Visibility( 
                  visible: isVisible == 2 ,
                  child: 
                Positioned( 
                  left: size.width / 2 - 30,
                  top: 100,
                  child:
                 Image.asset("assets/img/pause.png"))),
                const Positioned(
                  top: 20,
                  left: 100,
                  child: Text("for you ",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
                Positioned(
                    top: 20,
                    left: 180,
                    child: Text(
                      "Followers",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(),
                            child: Visibility(
                              visible: isVisible != 2,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // ignore: prefer_const_constructors
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.star_rate_sharp,
                                            color: Colors.amber),
                                        Icon(Icons.star_rate_sharp,
                                            color: Colors.amber),
                                        Icon(Icons.star_rate_sharp,
                                            color: Colors.amber),
                                        Icon(Icons.star_rate_sharp,
                                            color: Colors.amber),
                                        Icon(Icons.star_rate_sharp,
                                            color: Colors.amber)
                                      ],
                                    ),
                                  ),

                                  // Row(
                                  //   children: [
                                  //     const Icon(
                                  //       Icons.music_note,
                                  //       size: 15,
                                  //       color: Colors.white,
                                  //     ),
                                  //     Text(
                                  //       data.songName,
                                  //       style: const TextStyle(
                                  //         fontSize: 15,
                                  //         color: Colors.white,
                                  //         fontWeight: FontWeight.bold,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          margin: EdgeInsets.only(top: 0, bottom: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              /*  buildProfile(
                                data.profilePhoto,
                              ), */
                              Visibility(
                                visible: isVisible != 2,
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      child:
                                          Image.asset("assets/img/ThumbUp.png"),
                                      onTap: () =>
                                          videoController.likeVideo(data.id),
                                    ),
                                    const SizedBox(height: 10),

                                    // ignore: sort_child_properties_last
                                    if (data.dislike.length +
                                            data.likes.length !=
                                        0)
                                      Row(
                                        children: [
                                          Container(
                                              height: 10,
                                              width: (data.likes.length /
                                                      (data.dislike.length +
                                                          data.likes.length)) *
                                                  45,
                                              color: Color.fromRGBO(
                                                  0, 255, 117, 1)),
                                          Container(
                                              height: 10,
                                              width: (data.dislike.length /
                                                      (data.dislike.length +
                                                          data.likes.length)) *
                                                  45,
                                              color: Color.fromRGBO(
                                                  241, 16, 16, 1))
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                      ),
                                    SizedBox(height: 10),
                                    InkWell(
                                      onTap: () =>
                                          videoController.dislikeVideo(data.id),
                                      child: Image.asset(
                                          "assets/img/ThumbDown.png"),
                                    ),
                                    SizedBox(height: 20),
                                    InkWell(
                                      child: Image.asset(
                                          "assets/img/Exclamation.png"),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: isVisible != 2,
                                child: Column(
                                  children: [
                                    Visibility(
                                      visible: isVisible == 1,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                              child: Image.asset(
                                                  "assets/img/Share.png")),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                              child: Image.asset(
                                                  'assets/img/save.png')),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Visibility(
                                                  visible: true,
                                                  child: Image.asset(
                                                      "assets/img/sidearrow.png")),
                                              Visibility(
                                                visible:  true,
                                                child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        flower = !flower;
                                                      });
                                                    },
                                                    child: Image.asset(
                                                        "assets/img/flower.png")),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                              child: Image.asset(
                                                  "assets/img/repost.png")),

                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    
                                    GestureDetector(
                                      child: Image.asset("assets/img/menu.png"),
                                      onTap: () {
                                        setState(() {
                                          if (isVisible != 1)
                                            isVisible = 1;
                                          else
                                            isVisible = 0;
                                            
                                            print(isVisible);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                        maintainState: true,
                        child: CommentScreen(
                          id: data.id,
                          isOpen: isVisible == 2,
                          onExpandClick: () => {
                            setState(() {
                              if (isVisible == 2)
                                isVisible = 0;
                              else
                                isVisible = 2;

                                print(isVisible);
                            })
                          },
                        ),
                        visible: isVisible != 1 ? true : false),
                  ],
                ),
              Positioned(bottom: 134,
                left: 20,
                  child: Visibility( visible: flower == true,
                    child: GestureDetector(onTap: () {setState(() {
                      if (isVisible ==1 )
                      flower = !flower ;
                      if (isVisible == 0)
                       flower =  !flower;
                    });
                      
                    },
                      child: Image.asset("assets/img/textbar.png"))),
                ),],
            );
          },
        );
      }),
    );
  }
}
