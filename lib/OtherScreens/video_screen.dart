import 'package:chewie/chewie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key, this.url}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();

  final url;
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  late ChewieController chewieController;
  bool showSpinner = true;

  Future<void> initializeVideoPlayer() async {
    // _controller = VideoPlayerController.network(
    //     "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");

    _controller = VideoPlayerController.network("${widget.url}");
    await Future.wait([_controller.initialize()]);
    chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  void initState() {
    super.initState();
    initializeVideoPlayer().then((value) {
      setState(() {
        showSpinner = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Center(
              child: showSpinner == true
                  ? CircularProgressIndicator(
                      strokeWidth: 3.0,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.pink,
                      ),
                    )
                  : Chewie(
                      controller: chewieController,
                    )),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    chewieController.dispose();
    super.dispose();
  }
}
