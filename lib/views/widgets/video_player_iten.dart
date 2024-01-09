import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  final bool isCommentOpen ;
  const VideoPlayerItem({
    Key? key, 
    required this.videoUrl, 
    required this.isCommentOpen
  }) : super(key: key);

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController videoPlayerController;
  bool isInited =  false ; 
  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((value) {
        isInited = true ;
        videoPlayerController.play();
        videoPlayerController.setVolume(1);
        videoPlayerController.setLooping(true);
        
      });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

@override
  void didUpdateWidget(covariant VideoPlayerItem oldWidget) {
    // TODO: implement didUpdateWidget
    if(widget.isCommentOpen == true )
        {print("isoo1 open");
          setPause();}
    else {
      print('isoo1 closed'); 
      setPlay();}
    super.didUpdateWidget(oldWidget);
  }

   void setPause()
  {
    if(isInited == false )
    return;
      videoPlayerController.pause();
      
    
  }
    void setPlay()
    {if(isInited == false )
    return;
      videoPlayerController.play();
    }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    videoPlayerController.setLooping(true);
    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: VideoPlayer(videoPlayerController),
    );
  }
}
