import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'package:DEAC/Menu/home.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class HtmlPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learn Page',
      home: LearnPage(),
    );
  }
}

class LearnPage extends StatefulWidget {
  @override
  _LearnPageState createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
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
        child :
        AspectRatio(
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
                  builder: (context) => FullScreenVideoPage(_controllers[index]),
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
      appBar: AppBar(
        backgroundColor: Color(0xFF00A9FA),
        elevation: 0,
        leading: IconButton(
  icon: Image.asset(
    'assets/icons/arrow.png', // Ganti dengan gambar kustom
    width: 60,
    height: 60,
  ),
  onPressed: () {
    // Hentikan semua video sebelum navigasi
    for (int i = 0; i < _controllers.length; i++) {
      if (_controllers[i].value.isPlaying) {
        _controllers[i].pause();
        _isPlayingList[i] = false; // Memperbarui status pemutaran
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
      body: Container(
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'LEARN',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: 20),
              // Container yang menampilkan HTML dan gambar
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
                      'assets/images/program/html.png', // Gambar di sebelah kiri teks HTML
                      width: 40,
                      height: 40,
                    ),
                    SizedBox(width: 10), // Jarak antara gambar dan teks
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
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.only(top: 16, bottom: 16),
                  margin: EdgeInsets.only(bottom: 20),
                  child: ListView.builder(
                    itemCount: videoAssets.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2), // Warna bayangan
        spreadRadius: 2, // Jarak penyebaran bayangan
        blurRadius: 5, // Tingkat kabur bayangan
        offset: Offset(0, 3), // Posisi bayangan (horizontal, vertical)
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
          videoTitles[index], // Menggunakan judul dari daftar
          style: TextStyle(
            fontFamily: 'Inter', // Mengatur font menjadi Inter
            fontSize: 16,
            fontWeight: FontWeight.w600, // Menggunakan semi-bold
          ),
        ),
      ),
      SizedBox(height: 10),
      Align(
        alignment: Alignment.bottomRight,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(14),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Text(
            _formatDuration(_controllers[index].value.duration),
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
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
  bool _isFullScreen = true; // To manage fullscreen toggle
  late Timer _hideControlsTimer;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (mounted) {
        setState(() {}); // Update UI when video state changes
      }
    });
    // Kunci orientasi ke landscape saat masuk fullscreen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _startHideControlsTimer();
  }

  @override
  void dispose() {
    // Kembalikan orientasi ke portrait saat keluar fullscreen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Batalkan timer saat widget dihapus
    _hideControlsTimer.cancel();
    widget.controller.removeListener(() {}); // Hapus listener
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
          _startHideControlsTimer(); // Start the timer again when video is playing
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _toggleControls,
        child: Stack(
          children: [
            // Fullscreen Video Player
            Center(
              child: AspectRatio(
                aspectRatio: widget.controller.value.aspectRatio,
                child: VideoPlayer(widget.controller),
              ),
            ),
            // Controls Overlay
            if (_showControls)
              Positioned.fill(
                child: GestureDetector(
                  onTap: _toggleControls,
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Video Progress Bar
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
                            // Play/Pause Button
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
                            // Video Position and Duration
                            Text(
                              '${_formatDuration(widget.controller.value.position)} / ${_formatDuration(widget.controller.value.duration)}',
                              style: TextStyle(color: Colors.white),
                            ),
                            // FullScreen Toggle Button
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context); // Exit fullscreen
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