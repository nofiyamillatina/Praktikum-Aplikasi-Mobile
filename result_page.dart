// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultPage extends StatelessWidget {
  final String nama, gender, kategori;
  final double bmi;

  const ResultPage(
      {required this.nama,
      required this.bmi,
      required this.gender,
      required this.kategori,
      super.key});

  String _getKategori() {
    if (bmi < 18.5) return 'Kurus';
    if (bmi < 25.0) return 'Normal';
    if (bmi < 30.0) return 'Gemuk';
    return "Obesitas";
  }

  String _getImage() {
    if (bmi < 18.5) {
      return 'images/Kurus.png';
    }
    if (bmi < 25.0) {
      return 'images/Normal.png';
    }
    return 'images/Obesitas.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "HASIL BMI",
        ),
        leading: BackButton(),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 120),
              Text(
                "Hallo, $nama !",
                style: GoogleFonts.raleway(
                    fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              Image.asset(
                _getImage(),
                height: 200,
              ),
              SizedBox(height: 30),
              Text(
                "Hasil BMI Kamu: ${bmi.toStringAsFixed(1)}",
                style: GoogleFonts.raleway(
                    fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              Text(
                "Kategori: ${_getKategori()}",
                style: GoogleFonts.raleway(
                    fontSize: 30, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(
                    context,
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(top: 50, left: 24, right: 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.blue,
                  ),
                  width: 300,
                  height: 50,
                  child: Center(
                    child: Text(
                      "HITUNG ULANG",
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
