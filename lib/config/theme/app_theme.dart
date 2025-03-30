import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(color: Colors.black),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF00A86B), // AppColors.GreenMain
      unselectedItemColor: Colors.grey,
      elevation: 20,
    ),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.inter(color: const Color(0xFF0C0C0C)),
      bodyMedium: GoogleFonts.lato(color: const Color(0xFFB1B1B1)),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF00A86B), // GreenMain
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blueGrey,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[900],
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(color: Colors.white),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey[850],
      selectedItemColor: const Color(0xFF00A86B), // AppColors.GreenMain
      unselectedItemColor: Colors.grey[400],
      elevation: 20,
    ),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.inter(color: Colors.white),
      bodyMedium: GoogleFonts.lato(color: Colors.grey[400]),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF00A86B), // GreenMain
    ),
  );
}