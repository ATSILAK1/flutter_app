import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_tutorial/constants.dart';
import 'package:tiktok_tutorial/controllers/comment_controller.dart';
import 'package:tiktok_tutorial/models/comment.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentScreen extends StatelessWidget {
  final String id;
  CommentScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  final TextEditingController _commentController = TextEditingController();
  CommentController commentController = Get.put(CommentController());
  Widget buildCommentContainer(Comment value)
  {
    return Container(width: double.infinity,
    child: Row(children: [//Image.network(value.profilePhoto),
     RichText(text: TextSpan(children: [
      TextSpan(text: value.username , style: TextStyle(fontWeight: FontWeight.bold)),TextSpan(text: value.comment)
    ]),)
    ],),);
  }
  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    commentController.updatePostId(id);
    if(commentController.comments.isEmpty) return Container();
    
    return buildCommentContainer(commentController.comments.first);
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
                      onTap: () =>
                          commentController.likeComment(comment.id),
                      child: Icon(
                        Icons.favorite,
                        size: 25,
                        color: comment.likes
                                .contains(authController.user.uid)
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
