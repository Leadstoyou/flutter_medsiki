import 'dart:async';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/base/base._repository.dart';
import 'package:untitled/screens/home/onboarding/home_onboarding_detail_screen.dart';
import 'package:untitled/utils/common.dart';
import 'package:untitled/utils/local_storage.dart';
import 'package:untitled/widgets/common.dart';
import 'package:video_player/video_player.dart';

class CourseDetailScreen extends StatefulWidget {
  final dynamic course;

  const CourseDetailScreen(this.course, {super.key});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

dynamic externalCourse;
dynamic externalWatchingVideoId;

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  get course => widget.course;
  final BaseRepository<Map<String, dynamic>> paymentsRepository =
  BaseRepository<Map<String, dynamic>>('payments');
  bool isBought = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    isThisCoursePaid();
  }

  Future<void> isThisCoursePaid() async {
    setState(() {
      _isLoading = true;
    });

    externalWatchingVideoId = await getUserWatchingVideoId();

    var listUserPayment = await paymentsRepository.search(
      'user', (await getUserFromLocalStorage())?.id ?? "",
    );

    if (listUserPayment.isNotEmpty) {
      var found = listUserPayment.where((element) => element['course']['id'] == course['id']);
      setState(() {
        isBought = found.isNotEmpty;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> videosList = [];
    externalCourse = course;
    if (course['videos'] is Map) {
      videosList = course['videos'].values.toList();
    } else if (course['videos'] is List) {
      videosList = course['videos'];
    } else {
      print('Unexpected videos data type: ${course['videos']}');
    }
    videosList.sort((a, b) => a['index'].compareTo(b['index']));

    String description = course['description'];
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildCommonAppBar(context, 'Thông tin'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            const SizedBox(height: 18),
            const Text(
              'Video hướng dẫn',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: ListView.builder(
                itemCount: videosList.length,
                itemBuilder: (context, index) {
                  return _buildItems(videosList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItems(dynamic video) {
    final String videoUrl = video['url'] ?? '';
    final String videoTitle = video['title'] ?? 'Unknown Title';
    final String videoPreview =
    video['isPreview'] || isBought ? 'Có sẵn' : 'Unavaiable';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          GestureDetector(
            onTap: () =>
            {
              video['isPreview']
                  ? _navigateToFullscreen(context, video)
                  : (navigate(context, HomeOnboardingDetailScreen(course)))
            },
            child: SizedBox(
              width: 80,
              height: 80,
              child: VideoPlayerThumbnail(videoUrl: videoUrl),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width : 180,
                        child: Text(
                          videoTitle,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        videoPreview,
                        style:
                        const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 60,
                    child: ElevatedButton(
                      onPressed: () =>
                      {
                        video['isPreview'] || isBought
                            ? _navigateToFullscreen(context, video)
                            : (navigate(
                            context, HomeOnboardingDetailScreen(course)))
                      },
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                              video['isPreview'] || isBought
                                  ? Color(0xFF990011)
                                  : Colors.white),
                          padding: WidgetStateProperty.all(
                            EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                          ),
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)))),
                      child: Text(
                        video['isPreview'] || isBought ? 'Xem' : "Thêm",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Manrope SemiBold',
                            color: video['isPreview'] || isBought
                                ? Colors.white
                                : Color(0xFF990011)),
                      ),
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  void _navigateToFullscreen(BuildContext context, dynamic video) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullscreenVideoPlayer(video: video),
      ),
    );
  }
}

class VideoPlayerThumbnail extends StatelessWidget {
  final String videoUrl;

  const VideoPlayerThumbnail({required this.videoUrl, Key? key})
      : super(key: key);

  String getThumbnailUrl(String videoUrl) {
    final regex = RegExp(r'(.*)/upload/(.*)\.mp4');
    final match = regex.firstMatch(videoUrl);
    if (match != null) {
      final prefix = match.group(1);
      final suffix = match.group(2);
      return '$prefix/upload/w_300,h_200,so_2,f_auto/$suffix.jpg';
    }
    return videoUrl;
  }

  @override
  Widget build(BuildContext context) {
    final thumbnailUrl = getThumbnailUrl(videoUrl);
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.network(
          thumbnailUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.black,
              child: const Icon(
                Icons.error,
                color: Colors.white,
                size: 40,
              ),
            );
          },
        ),
        // Icon play
        const Icon(
          Icons.play_circle_fill,
          color: Colors.white,
          size: 40,
        ),
      ],
    );
  }
}

class FullscreenVideoPlayer extends StatefulWidget {
  final dynamic video;

  const FullscreenVideoPlayer({required this.video, super.key});

  @override
  _FullscreenVideoPlayerState createState() => _FullscreenVideoPlayerState();
}

class _FullscreenVideoPlayerState extends State<FullscreenVideoPlayer> {
  // late VideoPlayerController _controller;

  bool _hasPrinted80 = false;
  late BetterPlayerController _betterPlayerController;
  @override
  void initState() {
    super.initState();
    //  better player
    BetterPlayerConfiguration betterPlayerConfiguration =
    BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
      autoPlay: true,
      looping: true,
      controlsConfiguration: BetterPlayerControlsConfiguration(
        enableFullscreen: true,
        enablePlaybackSpeed: true,
        enableProgressText: true,
      ),
    );
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.video['url'] ?? "",
    );
    print(' BetterPlayerDataSource dataSource ::  ' +dataSource.url.toString() );

    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
    _betterPlayerController.addEventsListener(_onPlayerEvent);
  }

  void _onPlayerEvent(BetterPlayerEvent event) async {
    print('_onPlayerEvent :: connected' + (event.betterPlayerEventType == BetterPlayerEventType.progress).toString());
    if (event.betterPlayerEventType == BetterPlayerEventType.progress) {
      print('_onPlayerEvent :: connected 1.2 ${event.betterPlayerEventType == BetterPlayerEventType.progress}');
      print('_onPlayerEvent :: connected 2'+ (_betterPlayerController.videoPlayerController! !=null).toString() +  " and " + _betterPlayerController.videoPlayerController!.value.initialized.toString());

      if (_betterPlayerController.videoPlayerController != null && _betterPlayerController.videoPlayerController!.value.initialized) {
        print('_onPlayerEvent :: connected 3');
        final duration = _betterPlayerController.videoPlayerController?.value.duration;
        final position = _betterPlayerController.videoPlayerController?.value.position;
        print("_onPlayerEvent :: duration.inSeconds ::" + duration!.inSeconds.toString() + " position.inSeconds ::" +
            duration.inSeconds.toString() + "_hasPrinted80 :: ");
        if (duration.inSeconds > 0 &&
            position!.inSeconds >= duration.inSeconds * 0.8 &&
            !_hasPrinted80) {
          _hasPrinted80 = true;
            var ref = BaseRepository<Map<String, dynamic>>('histories')
                .getRef()
                .child(externalWatchingVideoId)
                .child('courses')
                .child(externalCourse['id'])
                .child(widget.video['index'].toString());

            var data = await ref.get();
            if (!data.exists) {
              var userHistory =
              await BaseRepository<Map<String, dynamic>>('histories')
                  .search('user', (await getUserFromLocalStorage())!.id ?? "");
              print('userHistory $userHistory');

              if (userHistory.isEmpty) {
                await BaseRepository<Map<String, dynamic>>('histories').create({
                  'user': (await getUserFromLocalStorage())!.id ?? "",
                  'courses': {
                    externalCourse['id']: {
                      widget.video['index'].toString(): true,
                    }
                  }
                });
              } else {
                await BaseRepository<Map<String, dynamic>>('histories')
                    .getRef()
                    .child(userHistory[0]["id"])
                    .child('courses')
                    .child(externalCourse['id'])
                    .update({
                  widget.video['index'].toString(): true,
                });
              }
            }
        }
      }
    }
  }
  // void _checkVideoProgress() async {
  //   if (!_controller.value.isInitialized) return;
  //
  //   final duration = _controller.value.duration;
  //   final position = _controller.value.position;
  //
  //   if (duration.inSeconds > 0 &&
  //       position.inSeconds >= duration.inSeconds * 0.8 &&
  //       !_hasPrinted80) {
  //     _hasPrinted80 = true;
  //     print(externalWatchingVideoId);
  //     print(externalCourse['id']);
  //     var ref = BaseRepository<Map<String, dynamic>>('histories')
  //         .getRef()
  //         .child(externalWatchingVideoId)
  //         .child('courses')
  //         .child(externalCourse['id'])
  //         .child(widget.video['index'].toString());
  //
  //     var data = await ref.get();
  //     if (!data.exists) {
  //       var userHistory =
  //       await BaseRepository<Map<String, dynamic>>('histories')
  //           .search('user', (await getUserFromLocalStorage())!.id ?? "");
  //       print('userHistory $userHistory');
  //       if (userHistory.isEmpty) {
  //         await BaseRepository<Map<String, dynamic>>('histories').create({
  //           'user': (await getUserFromLocalStorage())!.id ?? "",
  //           'courses': {
  //             externalCourse['id']: {
  //               widget.video['index'].toString(): true,
  //             }
  //           }
  //         });
  //       } else {
  //         await BaseRepository<Map<String, dynamic>>('histories')
  //             .getRef()
  //             .child(userHistory[0]["id"])
  //             .child('courses')
  //             .child(externalCourse['id'])
  //             .update({
  //           widget.video['index'].toString(): true,
  //         });
  //       }
  //     }
  //     _hasPrinted80 = true;
  //   }
  // }

  @override
  void dispose() {
    _betterPlayerController.removeEventsListener(_onPlayerEvent);
    _betterPlayerController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: BetterPlayer(controller: _betterPlayerController),
      ),
    );
  }
}
