import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerScreen({required this.videoUrl, Key? key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the video URL
    _controller = VideoPlayerController.network(widget.videoUrl);
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      setState(() {}); // Refresh the UI once the video is initialized
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    VideoPlayer(_controller),
                    if (!_controller.value.isPlaying)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _controller.play();
                          });
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
                _controller,
                allowScrubbing: true, // Enable scrubbing for user interaction
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
                      _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    ),
                    onPressed: () {
                      setState(() {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.fullscreen),
                    onPressed: () {
                      _navigateToFullscreen();
                    },
                  ),
                ],
              ),
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  void _navigateToFullscreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullscreenVideoPlayer(
          controller: _controller,
        ),
      ),
    );
  }
}

class FullscreenVideoPlayer extends StatelessWidget {
  final VideoPlayerController controller;

  const FullscreenVideoPlayer({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        ),
      ),
    );
  }
}
