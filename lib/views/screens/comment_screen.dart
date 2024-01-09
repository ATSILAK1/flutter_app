// ignore_for_file: sort_child_properties_last, avoid_unnecessary_containers, curly_braces_in_flow_control_structures

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_tutorial/constants.dart';
import 'package:tiktok_tutorial/controllers/comment_controller.dart';
import 'package:tiktok_tutorial/controllers/video_controller.dart';
import 'package:tiktok_tutorial/models/comment.dart';
import 'package:tiktok_tutorial/models/video.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentScreen extends StatefulWidget {
  final String id;
  final bool isOpen;
  final void Function() onExpandClick;
  CommentScreen(
      {Key? key,
      required this.id,
      required this.isOpen,
      required this.onExpandClick})
      : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();

  CommentController commentController = Get.put(CommentController());
  VideoController _videoController = Get.put(VideoController());

  Widget buildCommentContainer(Comment value, Color colors) {
    return 
    ClipRRect(
      child: BackdropFilter(
        filter:  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          width: double.infinity,
          child: Row(
            children: [SizedBox(width: 5,),
              Container(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black, // Shadow color
                        offset: Offset(10, 5), // Offset of the shadow
                        blurRadius: 0, // Blur radius of the shadow
                      ),
                    ],
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: value.profilePhoto,
                    height: 60,
                    width: 60,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: value.username,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Anek Tamil')),
                  TextSpan(text: " " + value.comment)
                ]),
              )
            ],
          ),
          decoration: BoxDecoration(color: colors),
        ),
      ),
    );
  }

  Widget buildCaptionContainer(Video value, Color colors) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          width: double.infinity,
          child: Row(
            children: [SizedBox(width: 5,),
              Container(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black, // Shadow color
                        offset: Offset(10, 5), // Offset of the shadow
                        blurRadius: 0, // Blur radius of the shadow
                      ),
                    ],
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: value.profilePhoto,
                    height: 60,
                    width: 60,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: value.username,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  TextSpan(text: " " + value.caption)
                ]),
              )
            ],
          ),
          decoration: BoxDecoration(color: colors),
        ),
      ),
    );
  }

  Widget buildEmptyCommentContainer() {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          RichText(
            text: TextSpan(children: [TextSpan(text: 'No Comments')]),
          )
        ],
      ),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.8)),
    );
  }

  @override
  void didUpdateWidget(covariant CommentScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('widget id :' + widget.id);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('widget id 2 :' + widget.id);
    updateComment();
  }

  List<Comment> commentsList = [];
  void updateComment() async {
    setState(() {
      commentsList = [];
    });
    print('widget id ' + widget.id);
    List<Comment> retValue = [];
    final docss = (await firestore
            .collection('videos')
            .doc(widget.id)
            .collection('comments')
            .get())
        .docs;
    for (var element in docss) {
      retValue.add(Comment.fromSnap(element));
    }

    setState(() {
      commentsList = List.from(retValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    print(widget.id);
    List _video = _videoController.videoList;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      
      children: [
        Align(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 35, 0),
              child: GestureDetector(
                child: widget.isOpen == true
                    ? Image.asset('assets/img/ArrowUiDown.png')
                    : Image.asset(
                        'assets/img/ArrowUi.png',
                      ),
                onTap: widget.onExpandClick,
              ),
            ),
            alignment: Alignment.centerRight),
        commentsList.isEmpty
            ? buildEmptyCommentContainer()
            : buildCaptionContainer(
                _video.where((element) => element.id == widget.id).firstOrNull,
                Colors.black.withOpacity(.8)),
      
        ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              child: Visibility(
                visible: widget.isOpen,
                child: Stack(children: [
                  Container(
                    height: 350,
                    decoration: BoxDecoration(color: Colors.black.withOpacity(0.8)),
                    child: ListView.builder(
                      itemCount: commentsList.length,
                      itemBuilder: (context, index) => buildCommentContainer(
                          commentsList[index], Colors.black.withOpacity(0)),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 45,
                    child: Container(
                      width: 300,
                      decoration: BoxDecoration(
                          border: Border.all(width: 0),
                          color: Color.fromRGBO(22, 22, 22, .5)),
                      child: TextField(
                        controller: _commentController,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Write something ...",
                          filled: true,
                          fillColor: Color.fromRGBO(22, 22, 22, 0.3),
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'AnekTamil',
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
    
        //  Visibility(
        //   visible:widget.isOpen ,
        //    child: TextButton(
        //     onPressed: () {
        //     print('text field '+ _commentController.text);
        //       print(" widget id ill"+ widget.id);
        //         commentController.updatePostId(widget.id);
        //         commentController.postComment(_commentController.text);
        //         },
        //     child: const Text(
        //       'Send',
        //       style: TextStyle(
        //         fontSize: 16,
        //         color: Colors.white,
        //       ),
        //     ),
        //                ),
        //  ),
      ],
    );
    // ignore: dead_code
    return SizedBox(
      width: double.infinity,
      height: 600,
      child: Column(
        children: [
          Obx(() {
            return ListView.builder(
                itemCount: commentController.comments.length,
                itemBuilder: (context, index) {
                  final comment = commentController.comments[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.black,
                      backgroundImage: NetworkImage(comment.profilePhoto),
                    ),
                    title: Row(
                      children: [
                        Text(
                          "${comment.username}  ",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          comment.comment,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          tago.format(
                            comment.datePublished.toDate(),
                          ),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${comment.likes.length} likes',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    trailing: InkWell(
                      onTap: () => commentController.likeComment(comment.id),
                      child: Icon(
                        Icons.favorite,
                        size: 25,
                        color: comment.likes.contains(authController.user.uid)
                            ? Colors.red
                            : Colors.white,
                      ),
                    ),
                  );
                });
          }),
          const Divider(),
          ListTile(
            title: TextFormField(
              controller: _commentController,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                labelText: 'Comment',
                labelStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            trailing: TextButton(
              onPressed: () =>
                  commentController.postComment(_commentController.text),
              child: const Text(
                'Send',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
