import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_health/screens/home_screen.dart';
import 'package:pet_health/view/login_page.dart';
import 'package:pet_health/view/register_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key});

  void navigateToHomeScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }

  void navigateToLoginPage(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  void navigateToRegisterPage(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => SignUpView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold adalah struktur dasar halaman
      body: Stack(
        // Menggunakan tumpukan (Stack) untuk menumpuk elemen-elemen
        children: [
          Image.asset(
            'images/assets/backk.png',
          ),
          Center(
            child: Center(
              child: SafeArea(
                // Menggunakan SafeArea untuk memastikan elemen-elemen tetap terlihat
                child: Column(
                  // Menyusun elemen dalam kolom vertikal
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 42,
                    ),
                    Image.asset(
                      // Menampilkan logo dari asset
                      'images/assets/logo.png',
                      height: 22,
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        // Teks dapat memiliki banyak gaya berbeda dalam satu blok
                        text: "Helping you\nto keep",
                        style: GoogleFonts.manrope(
                          fontSize: 24,
                          color: Color(0xFFDEE1FE),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "\tyour bestie",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextSpan(text: "\nstay healthy"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height:
                          30, // Ganti ketinggian sesuai kebutuhan (misalnya 30 untuk 3cm)
                    ),
                    const SizedBox(
                      height:
                          30, // Ganti ketinggian sesuai kebutuhan (misalnya 30 untuk 3cm)
                    ),
                    ElevatedButton(
                      onPressed: () => navigateToRegisterPage(context),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(
                            255, 129, 249, 155), // Warna latar belakang
                        onPrimary: Colors.white, // Warna teks
                        padding: EdgeInsets.symmetric(
                            vertical: 16, horizontal: 32), // Ukuran tombol
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30), // Bentuk tombol bulat
                        ),
                      ),
                      child: Text(
                        "Sign UP",
                        style: GoogleFonts.manrope(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height:
                          30, // Ganti ketinggian sesuai kebutuhan (misalnya 30 untuk 3cm)
                    ),
                    ElevatedButton(
                      onPressed: () => navigateToLoginPage(context),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(
                            255, 129, 249, 155), // Warna latar belakang
                        onPrimary: Colors.white, // Warna teks
                        padding: EdgeInsets.symmetric(
                            vertical: 16, horizontal: 32), // Ukuran tombol
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30), // Bentuk tombol bulat
                        ),
                      ),
                      child: Text(
                        "Sign In",
                        style: GoogleFonts.manrope(
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
