import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class First extends StatefulWidget {
  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  late VideoPlayerController _controller1;
  late VideoPlayerController _controller2;

  @override
  void initState() {
    super.initState();
    _controller1 = VideoPlayerController.asset("../../videos/drums.mp4")
      ..initialize().then((_) {
        setState(() {
          _controller1.setLooping(true);
        });
      });
    _controller2 = VideoPlayerController.asset("../../videos/drums.mp4")
      ..initialize().then((_) {
        setState(() {
    _controller2.setLooping(true);
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Row(
        children: [
          _controller1.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller1.value.aspectRatio,
                  child: VideoPlayer(_controller1),
                )
              : Container(),
          _controller2.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller2.value.aspectRatio,
                  child: VideoPlayer(_controller2),
                )
              : Container(),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            togglePlaying();
          });
        },
        child: Icon(
          _controller1.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  void startBothPlayers() async {
    await _controller1.play();
    await _controller2.play();
  }

  void stopBothPlayers() async {
    await _controller1.pause();
    await _controller2.pause();
  }

  void togglePlaying() {
    _controller1.value.isPlaying || _controller2.value.isPlaying ? stopBothPlayers() : startBothPlayers();
  }

  @override
  void dispose() {
    super.dispose();
    _controller1.dispose();
    _controller2.dispose();
  }
}
