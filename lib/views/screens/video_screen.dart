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
  State<StatefulWidget> createState() =>_VideoScreenState();
    
}


class _VideoScreenState extends State<VideoScreen> {
  
  final VideoController videoController = Get.put(VideoController());
  bool isVisible = false ;



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

                ),
                Container(child: CommentScreen(id: data.id,), )
                ,
                const Positioned(child: Text("for you ",style: TextStyle(color: Colors.blue , fontSize: 30)) ,),
                Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(
                                left: 20,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // ignore: prefer_const_constructors
                                  Row(children: [
                                  Icon(Icons.star_rate_sharp , color: Colors.amber),
                                  Icon(Icons.star_rate_sharp , color: Colors.amber),
                                  Icon(Icons.star_rate_sharp , color: Colors.amber),
                                  Icon(Icons.star_rate_sharp , color: Colors.amber),
                                  Icon(Icons.star_rate_sharp , color: Colors.amber)],)
                                  ,
                                  Text(
                                    data.username,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    data.caption,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
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
                          Container(
                            width: 100,
                            margin: EdgeInsets.only(top: size.height / 5 ,bottom: 50),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              
                              children: [
                              /*  buildProfile(
                                  data.profilePhoto,
                                ), */
                                Column(
                                  children: [
                                  GestureDetector(
                                    child: Image.asset("assets/img/ThumbUp.png"),
                                    onTap: () =>
                                          videoController.likeVideo(data.id) ,
                                  ),
                                    const SizedBox(height: 7),
                                    
                                     // ignore: sort_child_properties_last
                                     if(data.dislike.length + data.likes.length != 0)
                                     Row(children: [
                                      Container(height: 10,width : (data.likes.length / (data.dislike.length + data.likes.length))*45 , color: Color.fromRGBO(0, 255, 117, 1)),

                                      Container(height: 10,width: (data.dislike.length / (data.dislike.length + data.likes.length))*45 , color: Color.fromRGBO(241, 16, 16, 1))
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.center,),
                                  ],
                                ),
                                Column(
                                  children: [InkWell(
                                      onTap: () =>
                                          videoController.dislikeVideo(data.id),
                                      child: Image.asset("assets/img/ThumbDown.png"),
                                    ),
                                   
                                    ],
                                ),
                                SizedBox( height:1),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => CommentScreen(
                                            id: data.id,
                                            
                                          ),
                                        ),
                                      ),
                                      child: Image.asset("assets/img/Exclamation.png"),
                                    ),
                                    const SizedBox(height: 7),
                                   
                                  ],
                                ),
                                Column(
                                  children: [
                                    
                                   Visibility(child: GestureDetector(child: Image.asset("assets/img/Share.png")),visible: isVisible ),
                                   SizedBox(height:7,),
                                   Visibility(child: GestureDetector(child: Image.asset('assets/img/save.png')),visible: isVisible),
                                   SizedBox(height:7,),
                                   Visibility(child: GestureDetector(child: Image.asset("assets/img/flower.png")),visible: isVisible),
                                   SizedBox(height:7,),
                                   
                                   GestureDetector(child: Image.asset("assets/img/menu.png") ,
                                   onTap: () { setState(() {
                                     isVisible = !isVisible;
                                   });  }
                                                                     
                                    
                                   ,)
                                   
                                  ],
                                ),
                               
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                  ],
                ),
              ],
              
            );
           
          },
          
        );
      }),
    );
  }
}
