
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SocialVideoPlayer extends StatefulWidget {
  final String url;
  final bool isUrl;

  const SocialVideoPlayer({Key? key, required this.url, required this.isUrl})
      : super(key: key);

  @override
  _SocialVideoPlayerState createState() => _SocialVideoPlayerState();
}

class _SocialVideoPlayerState extends State<SocialVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  bool isVideoPlaying = false;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = widget.isUrl
        ? VideoPlayerController.networkUrl(Uri.parse(widget.url))
        : VideoPlayerController.asset(widget.url);

    _videoPlayerController.addListener(_handleVideoPlayerListener);
    _initializeVideoPlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.removeListener(_handleVideoPlayerListener);
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _initializeVideoPlayer() async {
    await _videoPlayerController.initialize();
    setState(() {
      isVideoPlaying = false;
    });
  }

  void _handleVideoPlayerListener() {
    final bool isPlaying = _videoPlayerController.value.isPlaying;
    if (isPlaying != isVideoPlaying) {
      setState(() {
        isVideoPlaying = isPlaying;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.url),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction >= 0.3 && !isVideoPlaying) {
          _videoPlayerController.play();
        } else if (visibility.visibleFraction < 0.3 && isVideoPlaying) {
          _videoPlayerController.pause();
        }
      },
      child: AspectRatio(
        aspectRatio: _videoPlayerController.value.aspectRatio,
      child: Chewie(
          controller: ChewieController(
            videoPlayerController: _videoPlayerController,
            looping: false,
            autoPlay: false,
            allowPlaybackSpeedChanging: false
          ),
        ),
      ),
    );
  }
}
