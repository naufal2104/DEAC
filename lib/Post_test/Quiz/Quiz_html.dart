import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      home: QuizHtmlScreen(level: 1), // Tambahkan argumen level
    );
  }
}

class QuizHtmlScreen extends StatefulWidget {
  final int level;

  QuizHtmlScreen({required this.level});

  @override
  _QuizHtmlScreenState createState() => _QuizHtmlScreenState();
}

class _QuizHtmlScreenState extends State<QuizHtmlScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  int _timeLeft = 30;
  Timer? _timer;
  bool _isAnswered = false;

  // List soal berdasarkan level
  final List<List<Map<String, dynamic>>> levelQuestions = [
    // Soal untuk Level 1
    [
      {
        'question': 'Apa kepanjangan dari HTML?',
        'answers': [
          'Hyper Text Markup Language',
          'Hyperlinks and Text Markup Language',
          'Home Tool Markup Language',
          'Hyperlink Text Media Language'
        ],
        'correctAnswer': 0
      },
      {
        'question': 'Tag apa yang digunakan untuk membuat paragraf di HTML?',
        'answers': ['<div>', '<p>', '<span>', '<h1>'],
        'correctAnswer': 1
      },
      {
        'question': 'Tag apa yang digunakan untuk membuat hyperlink?',
        'answers': ['<a>', '<link>', '<href>', '<anchor>'],
        'correctAnswer': 0
      },
      {
        'question': 'Tag apa yang digunakan untuk memasukkan gambar di HTML?',
        'answers': ['<img>', '<picture>', '<src>', '<image>'],
        'correctAnswer': 0
      },
      {
        'question': 'Apa atribut untuk menentukan tujuan URL dalam tag <a>?',
        'answers': ['src', 'href', 'alt', 'target'],
        'correctAnswer': 1
      },
    ],
    // Soal untuk Level 2
    [
      {
        'question': 'Apa yang dimaksud dengan tag <br> di HTML?',
        'answers': ['Break Line', 'Bold Text', 'Break Row', 'Block Row'],
        'correctAnswer': 0
      },
      {
        'question': 'Tag apa yang digunakan untuk membuat daftar tak berurutan?',
        'answers': ['<ul>', '<ol>', '<li>', '<dl>'],
        'correctAnswer': 0
      },
      {
        'question': 'Tag apa yang digunakan untuk memasukkan form di HTML?',
        'answers': ['<form>', '<input>', '<button>', '<textarea>'],
        'correctAnswer': 0
      },
      {
        'question': 'Atribut apa yang digunakan untuk memberikan deskripsi gambar?',
        'answers': ['src', 'href', 'alt', 'title'],
        'correctAnswer': 2
      },
      {
        'question': 'Apa yang digunakan untuk membuat tabel di HTML?',
        'answers': ['<table>', '<row>', '<td>', '<column>'],
        'correctAnswer': 0
      },
    ],
    // Soal untuk Level 3
    [
      {
        'question': 'Apa fungsi dari tag <head>?',
        'answers': [
          'Menampilkan judul',
          'Menyimpan metadata',
          'Menambahkan konten',
          'Mengatur paragraf'
        ],
        'correctAnswer': 1
      },
      {
        'question': 'Tag apa yang digunakan untuk membuat judul di HTML?',
        'answers': ['<h1>', '<p>', '<title>', '<header>'],
        'correctAnswer': 0
      },
      {
        'question': 'Tag <th> di HTML digunakan untuk?',
        'answers': [
          'Membuat judul tabel',
          'Menampilkan teks besar',
          'Membuat tautan',
          'Menambahkan gambar'
        ],
        'correctAnswer': 0
      },
      {
        'question': 'Apa yang dimaksud dengan tag <body> di HTML?',
        'answers': [
          'Menyimpan metadata',
          'Mengatur layout',
          'Menampilkan konten utama',
          'Menampilkan header'
        ],
        'correctAnswer': 2
      },
      {
        'question': 'Apa fungsi dari atribut "action" pada form?',
        'answers': [
          'Menampilkan pesan',
          'Menyimpan data',
          'Mengirimkan data',
          'Menghubungkan link'
        ],
        'correctAnswer': 2
      },
    ],
  ];

  @override
  void initState() {
    super.initState();

    // Panggil countdown setelah frame selesai dibangun
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showCountdown();
    });
  }

  void _showCountdown() {
    showDialog(
      context: context,
      builder: (context) {
        return CountdownDialog(onCountdownComplete: () {
          Navigator.of(context).pop(); // Tutup dialog
          startTimer(); // Panggil startTimer setelah dialog ditutup
        });
      },
    );
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        if (mounted) {
          setState(() {
            _timeLeft--;
          });
        }
      } else {
        timer.cancel();
        if (mounted) {
          _showTimeUpDialog();
        }
      }
    });
  }

  void _showTimeUpDialog() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LeaderboardHtmlPage(
          score: _score,
          onExit: () {
            Navigator.pop(context, true); // Return 'true' to unlock the next level
          },
        ),
      ),
    );
  }

  void checkAnswer(int index) {
    if (_isAnswered) return;

    setState(() {
      _isAnswered = true;
      if (index == levelQuestions[widget.level - 1][_currentQuestionIndex]['correctAnswer']) {
        _score += 20; // Poin per jawaban benar
      }

      Future.delayed(Duration(seconds: 1), () {
        if (_currentQuestionIndex < levelQuestions[widget.level - 1].length - 1) {
          setState(() {
            _currentQuestionIndex++;
            _isAnswered = false;
            _timeLeft = 30;
            startTimer();
          });
        } else {
          _showTimeUpDialog(); // Panggil dialog setelah kuis selesai
        }
      });
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Level ${widget.level} Quiz'),
      automaticallyImplyLeading: false, // Hide the default back button
      centerTitle: true,
    ),
    body: Stack(
      children: [
        // Garis waktu di bagian atas
        Positioned(
          top: 16,
          left: 16,
          right: 16,
          child: LinearProgressIndicator(
            value: _timeLeft / 30,
            backgroundColor: Colors.red,
            color: Colors.green,
          ),
        ),
        // Menampilkan nomor pertanyaan dan skor di sisi kiri dan kanan
        Positioned(
          top: 50,
          left: 16,
          child: Text(
            'Question ${_currentQuestionIndex + 1}/${levelQuestions[widget.level - 1].length}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(
          top: 50,
          right: 16,
          child: Text(
            'Score: $_score',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Mengatur agar soal dan jawaban tetap berjarak
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: Center(
          child: Text(
            levelQuestions[widget.level - 1][_currentQuestionIndex]['question'],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      // List of answer buttons without scrolling
      Column(
  children: List.generate(
    levelQuestions[widget.level - 1][_currentQuestionIndex]['answers'].length,
    (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Padding luar untuk kotak jawaban
        child: SizedBox(
          width: double.infinity, // Lebar kotak jawaban mengikuti lebar layar
          child: ElevatedButton(
            onPressed: () => checkAnswer(index),
            style: ElevatedButton.styleFrom(
              backgroundColor: _isAnswered
                  ? (index == levelQuestions[widget.level - 1][_currentQuestionIndex]['correctAnswer']
                      ? Colors.green
                      : Colors.red)
                  : Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0), // Padding internal (horizontal) pada teks di dalam kotak jawaban
            ),
            child: Text(
              levelQuestions[widget.level - 1][_currentQuestionIndex]['answers'][index],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    },
  ),
),
      SizedBox(height: 20), // Jarak antara jawaban dan bagian bawah layar
    ],
  ),
),

      ],
    ),
  );
}




  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}


// Halaman Leaderboard
class LeaderboardHtmlPage extends StatelessWidget {
  final int score; // Skor yang diterima dari halaman sebelumnya
  final VoidCallback onExit; // Callback untuk mengatur level saat keluar

  LeaderboardHtmlPage({required this.score, required this.onExit});

  // Data leaderboard statis
  final List<Map<String, dynamic>> leaderboardData = [
    {'name': 'Naufal Abdulillah', 'score': 100},
    {'name': 'Aril Maulana', 'score': 100},
    {'name': 'Ardo', 'score': 100},
    {'name': 'Zikra', 'score': 75},
    {'name': 'Rizki', 'score': 75},
    {'name': 'Sintiya', 'score': 75},
    {'name': 'Ricci', 'score': 75},
    {'name': 'Aditya', 'score': 75},
    {'name': 'Mulyawan', 'score': 50},
    {'name': 'Roy', 'score': 50},
  ];

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    // Menambahkan skor pemain ke dalam leaderboard
    leaderboardData.add({'name': 'You', 'score': score});

    return Scaffold(
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.05),

              // Tombol Kembali
              // Tombol Kembali di LeaderboardHtmlPage
IconButton(
  icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
  onPressed: () {
    // Return 'true' to unlock the next level
    Navigator.pop(context, true);
  },
),


              SizedBox(height: screenHeight * 0.02),

              // Judul Leaderboard
              Text(
                'Leaderboard',
                style: TextStyle(
                  fontFamily: 'InriaSerif', // Menggunakan font InriaSerif
                  fontSize: screenHeight * 0.03,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Kotak Informasi
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
                margin: EdgeInsets.only(bottom: screenHeight * 0.02),
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

              // Container Scrollable untuk leaderboard
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    itemCount: leaderboardData.length, // Jumlah dinamis berdasarkan data
                    itemBuilder: (context, index) {
                      final player = leaderboardData[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: Offset(0, 3), // Shadow posisi
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              player['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              player['score'].toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
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
}

// Countdown Dialog
class CountdownDialog extends StatelessWidget {
  final VoidCallback onCountdownComplete;

  CountdownDialog({required this.onCountdownComplete});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('Countdown')), // Memastikan judul juga di tengah
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center, // Pusatkan isi kolom
        children: [
          Text('The quiz will start in:', textAlign: TextAlign.center), // Pusatkan teks deskripsi
          SizedBox(height: 20),
          CountdownTimer(onComplete: onCountdownComplete), // Countdown sudah berada di Center di dalam widget ini
        ],
      ),
    );
  }
}


class CountdownTimer extends StatefulWidget {
  final VoidCallback onComplete;

  CountdownTimer({required this.onComplete});

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  int _counter = 3;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        timer.cancel();
        widget.onComplete();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_counter',
      style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
    );
  }
}
