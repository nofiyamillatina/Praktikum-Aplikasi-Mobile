import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/input_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalkulator BMI',
      theme: ThemeData(
        primaryColor: Color(0xFF4FC3F7),
        scaffoldBackgroundColor: Color(0xFFCDEFFD),
        textTheme: GoogleFonts.ralewayTextTheme(),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFCDEFFD),
          centerTitle: true,
          titleTextStyle: GoogleFonts.ptSerif(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
          iconTheme: IconThemeData(
            color: Colors.blue.shade900,
          ),
        ),
      ),
      home: InputPage(),
    );
  }
}
