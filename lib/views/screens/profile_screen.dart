// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:tiktok_tutorial/constants.dart';
import 'package:tiktok_tutorial/controllers/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.updateUserId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (controller.user.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            
            body: SafeArea(
              child: SingleChildScrollView( 
                
                child: Column(
                  
                  children: [
                    SizedBox( 
                      child: Column(
                        
                        children: [
                          Container( decoration: BoxDecoration(color: Color.fromRGBO( 57, 219, 255,1)),
                            padding: EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column( children: [
                                  Row(children:[GestureDetector(child: Image.asset("assets/img/ThumbUp.png"), )],),
                                  Row(children: [Text('1000' , style: TextStyle(color: Colors.black),)],)
                                ],                         
                                )
                               
                                ,
                                Column(
                                  children: [
                                    Container(
                                      child: DecoratedBox(decoration: BoxDecoration(boxShadow:[
                                              BoxShadow(color: Colors.black, // Shadow color
                                                        offset: Offset(10, 5), // Offset of the shadow
                                                        blurRadius: 0, // Blur radius of the shadow
                                                                ),], ),
                                        child: CachedNetworkImage(
                                          
                                          fit: BoxFit.cover,
                                          imageUrl: controller.user['profilePhoto'],
                                          height: 100,
                                          width: 100,
                                          
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                            Icons.error,
                                          ),
                                        ),
                                      ),
                                      
                                    ),
                                    Text('@'+controller.user['name'] , style: TextStyle(
                                      fontSize: 19,
                                      color: Colors.black,
                                      fontFamily: 'Anek Tamil'),)
                                  ],
                                ),
                                 Column(children: [
                                  Row(children:[GestureDetector(child: Image.asset("assets/img/ArrowUpDown.png"),)],),
                                  Row(children: [Text('1000  |  1000' ,style: TextStyle(color: Colors.black))],)])
                              ],
                            ),
                          ),
                          Container( decoration: BoxDecoration(color: Color.fromRGBO( 57, 219, 255,1)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  
                                  GestureDetector(child: Image.asset("assets/img/SendMessage.png"),),
                                  Column(children: [Icon(Icons.star_sharp , color: Colors.amber,),
                                  Text('1.45k')],),
                                  GestureDetector(
                                    onTap:  () {
                                      if (widget.uid == authController.user.uid) {
                                        authController.signOut();
                                      } else {
                                        controller.followUser();
                                      }
                                    },
                                    child: widget.uid == authController.user.uid ? Image.asset("assets/img/Settings.png"): controller.user['isFollowing']
                                              ? Image.asset("assets/img/Follow.png")
                                              : Image.asset("assets/img/Followed.png") ,  )
                                  // Column(
                                  //   children: [
                                  //     Text(
                                  //       controller.user['following'],
                                  //       style: const TextStyle(
                                  //         fontSize: 20,
                                  //         fontWeight: FontWeight.bold,
                                  //       ),
                                  //     ),
                                  //     const SizedBox(height: 5),
                                  //     const Text(
                                  //       'Following',
                                  //       style: TextStyle(
                                  //         fontSize: 14,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  // Container(
                                  //   color: Colors.black54,
                                  //   width: 1,
                                  //   height: 15,
                                  //   margin: const EdgeInsets.symmetric(
                                  //     horizontal: 15,
                                  //   ),
                                  // ),
                                  // Column(
                                  //   children: [
                                  //     Text(
                                  //       controller.user['followers'],
                                  //       style: const TextStyle(
                                  //         fontSize: 20,
                                  //         fontWeight: FontWeight.bold,
                                  //       ),
                                  //     ),
                                  //     const SizedBox(height: 5),
                                  //     const Text(
                                  //       'Followers',
                                  //       style: TextStyle(
                                  //         fontSize: 14,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  // Container(
                                  //   color: Colors.black54,
                                  //   width: 1,
                                  //   height: 15,
                                  //   margin: const EdgeInsets.symmetric(
                                  //     horizontal: 15,
                                  //   ),
                                  // ),
                                  // Column(
                                  //   children: [
                                  //     Text(
                                  //       controller.user['likes'],
                                  //       style: const TextStyle(
                                  //         fontSize: 20,
                                  //         fontWeight: FontWeight.bold,
                                  //       ),
                                  //     ),
                                  //     const SizedBox(height: 5),
                                  //     const Text(
                                  //       'Likes',
                                  //       style: TextStyle(
                                  //         fontSize: 14,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Container(child: Align(alignment: Alignment.centerLeft,
                                      child: Text('Bio'))),
                         ),
                          Container(
                            decoration: BoxDecoration(color:Color.fromRGBO(40, 40, 40, 0.79)),
                            child: Center(
                              
                              child: Row(mainAxisAlignment:MainAxisAlignment.spaceAround ,children: 
                              [
                              ElevatedButton(onPressed: null, child: Text('ALL') , style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(0, 0, 0, 0))), ),
                              Text('|'),
                              ElevatedButton(onPressed: null, child: Text('POST'),style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(0, 0, 0, 0)))),
                              Text('|'),
                              ElevatedButton(onPressed: null, child: Text('REPOST'),style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(0, 0, 0, 0))))
                              ],)
                            ),
                          ),
                          
                          // video list
                          GridView.builder(
                            
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.user['thumbnails'].length,
                            gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.5,
                              crossAxisSpacing: 5,
                            ),
                            itemBuilder: (context, index) {
                              String thumbnail =
                                  controller.user['thumbnails'][index];
                              return Stack(
                                
                                children:[
                                  CachedNetworkImage(
                                  imageUrl: thumbnail,
                                  fit: BoxFit.cover, 
                                ),
                                  Positioned(
                                    child: 
                                    Row(
                                      children: [
                                        Image.asset('assets/img/VideoPlay.png')
                                        ,
                                        Text("10",style: TextStyle(
                                          color: Color.fromARGB(255, 255, 255, 255) , fontSize: 20)),
                                      ],
                                    ),bottom: 22,)   
                                  ]
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
