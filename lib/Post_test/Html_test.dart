import 'package:flutter/material.dart';
import 'package:DEAC/Post_test/Quiz/Quiz_html.dart'; // Ganti dengan path ke file QuizHtmlScreen

class HtmlTestPage extends StatefulWidget {
  @override
  _HtmlTestPageState createState() => _HtmlTestPageState();
}

class _HtmlTestPageState extends State<HtmlTestPage> {
  int currentLevel = 1; // Level awal yang terbuka

  @override
void didChangeDependencies() {
  super.didChangeDependencies();
  final bool? isLevelUnlocked = ModalRoute.of(context)?.settings.arguments as bool?;
  print('isLevelUnlocked: $isLevelUnlocked'); // Tambahkan ini untuk debugging
  if (isLevelUnlocked == true) {
    setState(() {
      currentLevel++;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

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
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: screenHeight * 0.02),

              // Judul
              Text(
                'Post-Test',
                style: TextStyle(
                  fontFamily: 'InriaSerif',
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

              // Grid Level
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: screenHeight * 0.02,
                    crossAxisSpacing: screenWidth * 0.04,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: 10, // Total 10 level
                  itemBuilder: (context, index) {
                    bool isLocked = index + 1 > currentLevel; // Cek apakah level terkunci

                    return GestureDetector(
                      onTap: isLocked
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QuizHtmlScreen(level: index + 1),
                                ),
                              ).then((value) {
                                if (value != null && value == true) {
                                  // Jika level berikutnya terbuka
                                  setState(() {
                                    currentLevel = index + 2; // Unlock level berikutnya
                                  });
                                }
                              });
                            },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Center(
                              child: Text(
                                'Level ${index + 1}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenHeight * 0.025,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (isLocked)
                              Positioned(
                                right: 10,
                                top: 10,
                                child: Icon(Icons.lock, color: Colors.red),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
