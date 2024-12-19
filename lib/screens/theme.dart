import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Thème clair
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    secondaryHeaderColor: Colors.white,
    primaryColor: const Color.fromARGB(255, 65, 65, 65),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.grey,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: GoogleFonts.lato(
        fontSize: 25.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    textTheme: TextTheme(
        bodyLarge: GoogleFonts.openSans(
          fontSize: 23.0,
          fontWeight: FontWeight.w300,
          color: Colors.black,
        ),
        displayLarge: GoogleFonts.openSans(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        displayMedium: GoogleFonts.openSans(
          fontSize: 23.0,
          fontWeight: FontWeight.w700,
          color: const Color.fromARGB(255, 148, 147, 147),
        ),
        displaySmall: GoogleFonts.openSans(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: const Color.fromARGB(255, 148, 147, 147),
        ),
        titleLarge: GoogleFonts.openSans(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        titleMedium: GoogleFonts.openSans(
          fontSize: 15.0,
          fontWeight: FontWeight.w100,
          color: Colors.black,
        ),
        titleSmall: GoogleFonts.openSans(
            fontSize: 15,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.italic,
            color: Colors.grey)),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.black,
    ),
  );

  // Thème sombre
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.white,
    secondaryHeaderColor: Colors.black,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      color: Colors.black,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: GoogleFonts.lato(
        fontSize: 25.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    textTheme: TextTheme(
        bodyLarge: GoogleFonts.openSans(
          fontSize: 23.0,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        displayLarge: GoogleFonts.openSans(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        displayMedium: GoogleFonts.openSans(
          fontSize: 23.0,
          fontWeight: FontWeight.w700,
          color: const Color.fromARGB(255, 148, 147, 147),
        ),
        displaySmall: GoogleFonts.openSans(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: const Color.fromARGB(255, 148, 147, 147),
        ),
        titleLarge: GoogleFonts.openSans(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        titleMedium: GoogleFonts.openSans(
          fontSize: 15.0,
          fontWeight: FontWeight.w100,
          color: Colors.white,
        ),
        titleSmall: GoogleFonts.openSans(
            fontSize: 15,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.italic,
            color: Colors.grey)),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.white,
    ),
  );

  // Méthode pour obtenir le thème en fonction du mode
  static ThemeMode getThemeMode(bool isDarkModeEnabled) {
    return isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light;
  }
}
