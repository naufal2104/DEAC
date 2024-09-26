import 'package:DEAC/Menu/home.dart';
import 'package:DEAC/util/ufont.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromRGBO(242, 246, 255, 1),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                //KOTAK HIJAU ATAS
                Container(
                  height: MediaQuery.of(context).size.height * 0.33,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(
                      color:  Color(0xFF88D8FF),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(110),
                        bottomRight: Radius.circular(110),
                      )),
                  child: Center(
                    child: Column(
                      children: [
                        // TEXT MASUKKAN AKUN
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.15,
                          ),
                          child: Text(
                            "Masuk Akun ",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: UFont.poppins,
                                fontSize: 22,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        // TEXT SELAMAT DATANG
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.01,
                            left: MediaQuery.of(context).size.width * 0.03,
                            right: MediaQuery.of(context).size.width * 0.03,
                          ),
                          child: Text(
                            "Selamat datang kembali! silahkan\nmasuk ke akun Anda ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: UFont.poppins,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // FORM
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.07,
                    right: MediaQuery.of(context).size.width * 0.07,
                    left: MediaQuery.of(context).size.width * 0.07,
                  ),
                  child: Center(
                      child: Column(
                    children: [
                      // EMAIL
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.width * 0.75,
                        ),
                        child: Text('Email'),
                      ),
                      // EMAIL INPUT
                      TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined),
                            hintText: 'Masukan Email',
                            hintStyle: TextStyle(
                                fontFamily: UFont.poppins,
                                fontStyle: FontStyle.italic,
                                color: const Color.fromARGB(111, 0, 0, 0),
                                fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color:  Color(0xFF88D8FF),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color:  Color(0xFF88D8FF),
                              ),
                            )),
                      ),
                      // PASSWORD
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.024,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.width * 0.66,
                        ),
                        child: Text('Password'),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.key_outlined),
                            hintText: 'Masukan Password',
                            hintStyle: TextStyle(
                                fontFamily: UFont.poppins,
                                fontStyle: FontStyle.italic,
                                color: const Color.fromARGB(111, 0, 0, 0),
                                fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color:  Color(0xFF88D8FF),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color:  Color(0xFF88D8FF),
                              ),
                            )),
                      ),
                      //LUPA PASSWORD
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.026,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.width * 0.5,
                        ),
                        child: Text(
                          'Lupa Password?',
                          style: TextStyle(
                            fontFamily: UFont.poppins,
                            color: Color.fromARGB(244, 0, 0, 0),
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  )),
                ),
                //TOMBOL LOGIN
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.04,
                    bottom: MediaQuery.of(context).size.height * 0.04,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.65,
                        decoration: const BoxDecoration(
                          color:  Color(0xFF88D8FF),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        child: const Center(
                          child: Text(
                            'Masuk',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        )),
                  ),
                ),
                // TEXT SUDAH PUNYA AKUN?
                Container(
                  child: Center(
                    child: Column(
                      children: [
                        //TEKS Sudah punya akun?
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Sudah punya akun? ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: UFont.poppins,
                                  color: Color.fromARGB(244, 0, 0, 0),
                                  fontSize: 14,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()),
                                  );
                                },
                                child: Text(
                                  'DAFTAR',
                                  style: TextStyle(
                                    fontFamily: UFont.poppins,
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //
                        //TEKS ATAU
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.01,
                            bottom: MediaQuery.of(context).size.height * 0.01,
                          ),
                          child: Text(
                            'Atau',
                            style: TextStyle(
                              fontFamily: UFont.poppins,
                              color: Color.fromARGB(244, 0, 0, 0),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        //LOGO GOGGLE & FACEBOOK
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width * 0.06,
                                ),
                                child: Container(
                                  child: Image.asset(
                                      'assets/images/login/Group 6902.png'),
                                ),
                              ),
                              Container(
                                child: Image.asset(
                                    'assets/images/login/Group 6903.png'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
