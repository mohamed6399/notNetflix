import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:notrenetflix/constance.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MoviePlayer extends StatefulWidget {
  final String movieId;
  const MoviePlayer({super.key, required this.movieId});

  @override
  State<MoviePlayer> createState() => _MoviePlayerState();
}

class _MoviePlayerState extends State<MoviePlayer> {
  YoutubePlayerController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
        initialVideoId: widget.movieId,
        flags: const YoutubePlayerFlags(
            autoPlay: false, mute: false, loop: true, hideThumbnail: true));
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller == null
        ? Center(
            child: SpinKitCircle(
              color: kPrimaryColor,
              size: 50.0,
            ),
          )
        : YoutubePlayer(
            controller: _controller!,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.red,
            progressColors: ProgressBarColors(
              playedColor: kPrimaryColor,
              handleColor: kPrimaryColor,
            ),
            onEnded: (YoutubeMetaData data) {
              _controller!.play();
              _controller!.pause();
            },
            onReady: () {
              _controller!.addListener(() {});
            },
          );
  }
}
