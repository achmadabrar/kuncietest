import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MusicPlayWidget extends StatefulWidget {
  final String? trackViewUrl;

  MusicPlayWidget({this.trackViewUrl});

  @override
  _MusicPlayWidget createState() =>
      _MusicPlayWidget(trackViewUrl: trackViewUrl);
}

class _MusicPlayWidget extends State<MusicPlayWidget> {
  final String? trackViewUrl;
  AudioPlayer audioPlugin = AudioPlayer();

  _MusicPlayWidget({this.trackViewUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          //Center Row contents vertically,
          children: [
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.fast_rewind,
                    color: Colors.black,
                    size: 24.0,
                    semanticLabel: 'Backward',
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: IconButton(
                  onPressed: () {
                    audioPlugin.play();
                  },
                  icon: Icon(
                    Icons.play_arrow,
                    color: Colors.black,
                    size: 24.0,
                    semanticLabel: 'Play',
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.fast_forward_rounded,
                    color: Colors.black,
                    size: 24.0,
                    semanticLabel: 'Forward',
                  ),
                ))
          ],
        ));
  }
}
