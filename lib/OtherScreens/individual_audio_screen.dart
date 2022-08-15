import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

class IndividualAudioScreen extends StatefulWidget {
  const IndividualAudioScreen(
      {Key? key, required this.array, required this.index})
      : super(key: key);

  final array, index;

  @override
  State<IndividualAudioScreen> createState() => _IndividualAudioScreenState();
}

class _IndividualAudioScreenState extends State<IndividualAudioScreen> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;

  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setAudio();

    //Listen to states
    audioPlayer.onDurationChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    //Listen to audio duration
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    // Listen to position
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    // ignore: avoid_print
    super.dispose();
  }

  Future setAudio() async {
    //Repeat song when completed
    // audioPlayer.setReleaseMode(ReleaseMode.loop);

    // Load audio
    String url = widget.array[widget.index]['musicUrl'];
    await audioPlayer.setSourceUrl(url).then((value) async {
      await audioPlayer.resume().then((value) {
        print("audio uploaded & played");
        setState(() {
          // isPlaying = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 70),
            Stack(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Icon(Icons.arrow_back, size: 30, color: pink),
                  ),
                ),
                Center(
                    child: Text(
                  'Music Time',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: black,
                      fontFamily: 'Syne',
                      fontSize: 25,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.bold,
                      height: 1),
                )),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                '${widget.array[widget.index]['MusicImage']}',
                // 'https://www.incimages.com/uploaded_files/image/1920x1080/getty_967041852_2000133320009280134_404284.jpg',
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
            ),
            Text(
              '${widget.array[widget.index]['MusicName']}',
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: pink),
            ),
            SizedBox(height: 4),
            Text(
              'By ${widget.array[widget.index]['Singer']}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
            ),
            Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) async {
                final position = Duration(seconds: value.toInt());
                await audioPlayer.seek(position);

                // Optional : Play audio if was paused
                await audioPlayer.resume().then((value) {
                  setState(() {
                    isPlaying = true;
                  });
                });
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatTime(position)),
                  Text(formatTime(duration)),
                ],
              ),
            ),
            CircleAvatar(
              radius: 35,
              child: IconButton(
                icon: Icon(
                  isPlaying == false ? Icons.pause : Icons.play_arrow,
                ),
                iconSize: 50,
                // color: pink,
                focusColor: pink,
                highlightColor: pink,
                splashColor: pink,
                hoverColor: pink,
                onPressed: () async {
                  print(isPlaying);
                  if (isPlaying == true) {
                    // isPlaying = false;
                    await audioPlayer.pause().then((value) {
                      setState(() {
                        // isPlaying = false;
                      });
                    });
                  } else {
                    isPlaying = true;
                    await audioPlayer.resume().then((value) {
                      setState(() {
                        // isPlaying = true;
                      });
                    });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
