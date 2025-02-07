import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class FullscreenVideoPlayer extends StatelessWidget {
  final VideoPlayerController controller;

  const FullscreenVideoPlayer({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: Stack(
              alignment: Alignment.center,
              children: [
                VideoPlayer(controller),
                if (!controller.value.isPlaying)
                  GestureDetector(
                    onTap: () {
                      controller.play();
                    },
                    child: const Icon(
                      Icons.play_circle_outline,
                      size: 64,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
          VideoProgressIndicator(
            controller,
            allowScrubbing: true,
            colors: VideoProgressColors(
              playedColor: Colors.red,
              bufferedColor: Colors.grey,
              backgroundColor: Colors.black12,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (controller.value.isPlaying) {
                    controller.pause();
                  } else {
                    controller.play();
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.fullscreen_exit, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
