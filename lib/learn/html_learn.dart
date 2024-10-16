import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'package:DEAC/Menu/home.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Html Page',
      home: HtmlPage(),
    );
  }
}

class HtmlPage extends StatefulWidget {
  @override
  _HtmlPageState createState() => _HtmlPageState();
}

class _HtmlPageState extends State<HtmlPage> {
  final List<VideoPlayerController> _controllers = [];
  final List<bool> _isPlayingList = [];

  final List<String> videoAssets = [
    'assets/vidio/vidio1.mp4', // Video 1
    'assets/vidio/vidio2.mp4', // Video 2
    'assets/vidio/vidio1.mp4', // Video 3 (Placeholder)
    'assets/vidio/vidio1.mp4', // Video 4 (Placeholder)
  ];

  // Daftar judul video
  final List<String> videoTitles = [
    'Pengenalan HTML',
    'Cara Menambahkan Audio dan Video pada Halaman Web dengan HTML',
    'Judul Video 3', // Judul placeholder
    'Judul Video 4', // Judul placeholder
  ];

  @override
  void initState() {
    super.initState();
    for (var videoAsset in videoAssets) {
      var controller = VideoPlayerController.asset(videoAsset)
        ..initialize().then((_) {
          setState(() {});
        });
      _controllers.add(controller);
      _isPlayingList.add(false);
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _playPauseVideo(int index) {
    setState(() {
      if (_controllers[index].value.isPlaying) {
        _controllers[index].pause();
        _isPlayingList[index] = false;
      } else {
        for (int i = 0; i < _controllers.length; i++) {
          if (i != index && _controllers[i].value.isPlaying) {
            _controllers[i].pause();
            _isPlayingList[i] = false;
          }
        }
        _controllers[index].play();
        _isPlayingList[index] = true;
      }
    });
  }

  Widget _buildVideoPlayer(int index) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: AspectRatio(
            aspectRatio: _controllers[index].value.aspectRatio,
            child: VideoPlayer(_controllers[index]),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: IconButton(
              iconSize: 44,
              icon: Icon(
                _isPlayingList[index] ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              ),
              onPressed: () => _playPauseVideo(index),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: IconButton(
            icon: Icon(Icons.fullscreen, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FullScreenVideoPage(_controllers[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background dan konten lainnya
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF00A9FA),
                  Color(0xFFBBE9FF),
                  Color(0xFF88D8FF),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Memberikan jarak antara ikon "arrow" dan teks "LEARN"
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                  Text(
                    'LEARN',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFC70700),
                          Color(0xFFF03E11),
                          Color(0xFFF1BF74),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/program/html.png',
                          width: 40,
                          height: 40,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'HTML',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      margin: EdgeInsets.only(bottom: 20),
                      child: ListView.builder(
                        itemCount: videoAssets.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.05,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    _buildVideoPlayer(index),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        videoTitles[index],
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 6),
                                        child: Text(
                                          _formatDuration(_controllers[index]
                                              .value
                                              .duration),
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Tombol Kembali di atas teks "LEARN" dengan jarak
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.07,
              left: MediaQuery.of(context).size.width *
                  0.0000001, // Lebih ke kiri
            ),
            child: IconButton(
              icon: Image.asset(
                'assets/icons/arrow.png',
                width: 40,
                height: 40,
              ),
              onPressed: () {
                // Hentikan semua video sebelum navigasi
                for (int i = 0; i < _controllers.length; i++) {
                  if (_controllers[i].value.isPlaying) {
                    _controllers[i].pause();
                    _isPlayingList[i] = false;
                  }
                }
                // Navigasi ke HomeScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}

class FullScreenVideoPage extends StatefulWidget {
  final VideoPlayerController controller;

  FullScreenVideoPage(this.controller);

  @override
  _FullScreenVideoPageState createState() => _FullScreenVideoPageState();
}

class _FullScreenVideoPageState extends State<FullScreenVideoPage> {
  bool _showControls = true;
  bool _isFullScreen = true;
  late Timer _hideControlsTimer;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _startHideControlsTimer();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _hideControlsTimer.cancel();
    widget.controller.removeListener(() {});
    super.dispose();
  }

  void _toggleControls() {
    if (mounted) {
      setState(() {
        _showControls = !_showControls;
      });
      if (_showControls) {
        _startHideControlsTimer();
      }
    }
  }

  void _startHideControlsTimer() {
    _hideControlsTimer = Timer(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  void _playPause() {
    if (mounted) {
      setState(() {
        if (widget.controller.value.isPlaying) {
          widget.controller.pause();
        } else {
          widget.controller.play();
          _startHideControlsTimer();
        }
      });
    }
  }

  String _formatDuration(Duration position) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(position.inMinutes.remainder(60));
    final seconds = twoDigits(position.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  void _seekForward() {
    final currentPosition = widget.controller.value.position;
    final newPosition = currentPosition + Duration(seconds: 10);
    widget.controller.seekTo(newPosition);
  }

  void _seekBackward() {
    final currentPosition = widget.controller.value.position;
    final newPosition = currentPosition - Duration(seconds: 10);
    widget.controller.seekTo(newPosition);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _toggleControls,
        onDoubleTapDown: (details) {
          final tapPosition = details.localPosition.dx;
          if (tapPosition < screenWidth / 2) {
            _seekBackward();
          } else {
            _seekForward();
          }
        },
        child: Stack(
          children: [
            Center(
              child: AspectRatio(
                aspectRatio: widget.controller.value.aspectRatio,
                child: VideoPlayer(widget.controller),
              ),
            ),
            if (_showControls)
              Positioned.fill(
                child: GestureDetector(
                  onTap: _toggleControls,
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        VideoProgressIndicator(
                          widget.controller,
                          allowScrubbing: true,
                          colors: VideoProgressColors(
                            playedColor: Colors.red,
                            backgroundColor: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: _playPause,
                              icon: Icon(
                                widget.controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            Text(
                              '${_formatDuration(widget.controller.value.position)} / ${_formatDuration(widget.controller.value.duration)}',
                              style: TextStyle(color: Colors.white),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                _isFullScreen
                                    ? Icons.fullscreen_exit
                                    : Icons.fullscreen,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
