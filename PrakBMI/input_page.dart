// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'result_page.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  String? _selectedCategory;

  final List<String> _categories = [
    'Anak-anak',
    'Remaja',
    'Dewasa',
  ];

  String? _selectedGender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Kalkulator BMI",
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // TextFormField untuk nama
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    style: GoogleFonts.raleway(
                        fontSize: 18, fontWeight: FontWeight.w500),
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mohon isi data ini'; // Pesan error jika kosong
                      }
                      return null; // Valid jika isi
                    },
                    decoration: InputDecoration(
                      labelText: 'Nama',
                      labelStyle: GoogleFonts.raleway(
                          fontSize: 18, fontWeight: FontWeight.w500),
                      prefixIcon: Icon(Icons.person),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                // TextFormField untuk berat badan
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Berat Badan",
                              style: GoogleFonts.raleway(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: _weightController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Mohon isi data ini'; // Pesan error jika kosong
                                }
                                return null; // Valid jika isi
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.raleway(
                                  fontSize: 30,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                hintText: '0',
                                suffixText: 'kg',
                                border: InputBorder.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    // TextFormField untuk tinggi badan
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.only(left: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Tinggi Badan",
                              style: GoogleFonts.raleway(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: _heightController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Mohon isi data ini'; // Pesan error jika kosong
                                }
                                return null; // Valid jika isi
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.raleway(
                                  fontSize: 30,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                hintText: '0',
                                suffixText: 'cm',
                                border: InputBorder.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                // Dropdown untuk kategori usia
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    decoration: InputDecoration(
                      labelText: 'Kategori Usia',
                      border: OutlineInputBorder(),
                    ),
                    hint: Text('Pilih kategori...'),
                    items: _categories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 25),
                // RadioListTile untuk jenis kelamin
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedGender = 'Laki-laki';
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                            border: Border.all(
                              color: _selectedGender == 'Laki-laki'
                                  ? Colors.blue
                                  : Colors.transparent,
                              width: 3,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.male,
                                size: 50,
                                color: Colors.blue,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Laki-laki",
                                style: GoogleFonts.raleway(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedGender = 'Perempuan';
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                            border: Border.all(
                              color: _selectedGender == 'Perempuan'
                                  ? Colors.pink
                                  : Colors.transparent,
                              width: 3,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.female,
                                size: 50,
                                color: Colors.pink,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Perempuan",
                                style: GoogleFonts.raleway(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),

                GestureDetector(
                  onTap: () {
                    if (_nameController.text.isNotEmpty &&
                        _weightController.text.isNotEmpty &&
                        _heightController.text.isNotEmpty) {
                      final berat = double.parse(_weightController.text);
                      final tinggi = double.parse(_heightController.text) / 100;
                      final bmi = berat / (tinggi * tinggi);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultPage(
                            nama: _nameController.text,
                            bmi: bmi,
                            gender: _selectedGender!,
                            kategori: _selectedCategory!,
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blue,
                    ),
                    width: 300,
                    height: 50,
                    child: Center(
                      child: Text(
                        "HITUNG BMI",
                        style: GoogleFonts.raleway(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
