import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,

            colors: [Color(0xffB8F5B1), Color(0xffF6FFF5)],
          ),
        ),

        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                // LOGO
                Container(
                  padding: EdgeInsets.all(25),

                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    shape: BoxShape.circle,

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),

                  child: Image.asset(
                    'images/Logo NCT.png',
                    width: 130,
                    height: 130,
                  ),
                ),

                SizedBox(height: 40),

                // TITLE
                Text(
                  'NCT',
                  style: GoogleFonts.poppins(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 4,
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  'Neo Culture Technology',
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                  ),
                ),

                Text(
                  'Merchandise List',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 70),

                // BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 60,

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff6DFF7A),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),

                      elevation: 8,
                    ),

                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ItemListPage()),
                      );
                    },

                    child: Text(
                      'Enter',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
