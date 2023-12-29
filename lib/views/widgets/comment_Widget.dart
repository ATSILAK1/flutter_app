import 'package:flutter/material.dart';
import 'package:tiktok_tutorial/controllers/comment_controller.dart';

class Comment_widget extends StatefulWidget {
  const Comment_widget({Key? key}) : super(key: key);

  @override
  State<Comment_widget> createState() => _Comment_widgetState();
}

class _Comment_widgetState extends State<Comment_widget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late CommentController commentController ; 


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    commentController = CommentController();
    commentController.getComment();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [Row(children: [],)],);
  }
}