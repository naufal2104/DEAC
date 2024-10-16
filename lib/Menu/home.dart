import 'package:DEAC/Menu/post_test.dart';
import 'package:flutter/material.dart';
import 'package:DEAC/learn/html_learn.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Layout',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  // Daftar judul menu
  final List<String> menuTitles = [
    'HTML',
    'CSS',
    'JAVASCRIPT',
    'PYTHON',
    'BOOTSTRAP',
    'PHP',
    'NODEJS',
    'RUBY',
    'LARAVEL',
  ];

  // Daftar gambar menu
  final List<String> menuImages = [
    'assets/images/program/html.png',
    'assets/images/program/css.png',
    'assets/images/program/javascript.png',
    'assets/images/program/python.png',
    'assets/images/program/bootstrap.png',
    'assets/images/program/php.png',
    'assets/images/program/nodejs.png',
    'assets/images/program/ruby.png',
    'assets/images/program/laravel.png',
  ];

  bool isLearnSelected = true;
  bool isPostTestSelected = false;
  bool isInfoSelected = false;

  @override
  void initState() {
    super.initState();
    // Timer untuk mengubah halaman iklan setiap 3 detik
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentIndex < 2) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }

      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  // item di menu bar
  Widget buildMenuBarItem({
    required IconData icon,
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(10),
        child: Icon(icon, color: isSelected ? Colors.blueAccent : Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.1),
        child: Container(
          color: Color(0xFF00A9FA), // Warna ditekan
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.account_circle,
                        color: Colors.white, size: 50), // warna ikon biasa
                    SizedBox(width: screenWidth * 0.02),
                    Text(
                      'NAUFAL',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenHeight * 0.020,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon:
                      Icon(Icons.email_outlined, color: Colors.white, size: 40),
                  onPressed: () {
                    // Aksi ketika ikon pesan ditekan
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF00A9FA), // Warna atas
              Color(0xFFBBE9FF), // Warna tengah
              Color(0xFF88D8FF), // Warna bawah
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // iklan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                height: screenHeight * 0.17, // Tinggi
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: PageView(
                  controller: _pageController,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset('assets/images/iklan/iklan1.png',
                          fit: BoxFit.cover),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset('assets/images/iklan/iklan2.png',
                          fit: BoxFit.cover),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset('assets/images/iklan/iklan3.png',
                          fit: BoxFit.cover),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),

            // Bar menu dengan ikon
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.01),
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildMenuBarItem(
                    icon: Icons.computer,
                    isSelected: isLearnSelected,
                    onPressed: () {
                      setState(() {
                        isLearnSelected = true;
                        isPostTestSelected = false;
                        isInfoSelected = false;
                      });
                    },
                  ),
                  buildMenuBarItem(
                    icon: Icons.book,
                    isSelected: isPostTestSelected,
                    onPressed: () {
                      setState(() {
                        isLearnSelected = false;
                        isPostTestSelected = true;
                        isInfoSelected = false;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PostTestScreen()), // Navigasi ke halaman Post Test
                      );
                    },
                  ),
                  buildMenuBarItem(
                    icon: Icons.info,
                    isSelected: isInfoSelected,
                    onPressed: () {
                      setState(() {
                        isLearnSelected = false;
                        isPostTestSelected = false;
                        isInfoSelected = true;
                      });
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.02),

            // Judul di atas grid
            Padding(
              padding: const EdgeInsets.only(
                  left: 32.0, right: 16.0, top: 16.0, bottom: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Learn',
                  style: TextStyle(
                    fontFamily: 'InriaSerif',
                    fontSize: screenHeight * 0.015,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            // Grid menu belajar
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(screenWidth * 0.02),
                  margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (screenWidth > 600)
                          ? 4
                          : 3, //  grid berdasarkan lebar layar
                      mainAxisSpacing: screenHeight * 0.01,
                      crossAxisSpacing: screenWidth * 0.02,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: menuTitles.length,
                    itemBuilder: (context, index) {
                      final double topMargin =
                          (index == 0 || index == 1 || index == 2)
                              ? screenHeight * 0.02
                              : 0.0;
                      return GestureDetector(
                        onTap: () {
                          // Navigasi ke halaman yang sesuai
                          switch (menuTitles[index]) {
                            case 'HTML':
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HtmlPage()));
                              break;
                            case 'CSS':
                              // Tambah navigasi ke halaman CSS
                              break;
                            case 'JAVASCRIPT':
                              // Tambah navigasi ke halaman JavaScript
                              break;
                            case 'PYTHON':
                              // Tambah navigasi ke halaman Python
                              break;
                            // Tambahkan case lainnya untuk menu lain
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: topMargin),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                              255, 255, 255, 255)
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    width: screenWidth * 0.2,
                                    height: screenWidth * 0.2,
                                  ),
                                  ClipRRect(
                                    child: Image.asset(
                                      menuImages[index],
                                      fit: BoxFit.cover,
                                      height: screenWidth * 0.12,
                                      width: screenWidth * 0.12,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Text(
                                menuTitles[index],
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: screenHeight * 0.015,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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