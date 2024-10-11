import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeModel {
  int? jour;
  String? matiere;
  String? heure_debut;
  String? heure_fin;
  String? salle;
  String? nom_prof;
  String? prenom_prof;
  String? atome;

  final Color kColorPrimary = Colors.teal; // Couleur principale statique

  ThemeData get greenMode {
    return ThemeData(
      primaryColor: kColorPrimary,
      iconTheme: IconThemeData(color: Colors.grey[900]),
      fontFamily: 'Manrope',
      scaffoldBackgroundColor: Colors.grey[100],
      brightness: Brightness.light,
      appBarTheme: _buildAppBarTheme(isDark: false),
      textTheme: _buildTextTheme(isDark: false),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: kColorPrimary,
        unselectedItemColor: Colors.grey[500],
      ),
    );
  }

  ThemeData get darkMode {
    return ThemeData(
      primaryColor: kColorPrimary,
      iconTheme: IconThemeData(color: Colors.white),
      fontFamily: 'Manrope',
      scaffoldBackgroundColor: Color(0xff303030),
      brightness: Brightness.dark,
      appBarTheme: _buildAppBarTheme(isDark: true),
      textTheme: _buildTextTheme(isDark: true),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[500],
      ),
    );
  }

  AppBarTheme _buildAppBarTheme({required bool isDark}) {
    return AppBarTheme(
      systemOverlayStyle:
          isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      color: isDark ? Colors.grey[900] : Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.grey[900]),
      actionsIconTheme:
          IconThemeData(color: isDark ? Colors.white : Colors.grey[900]),
      titleTextStyle: TextStyle(
        fontFamily: 'Manrope',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.6,
        wordSpacing: 1,
        color: isDark ? Colors.white : Colors.grey[900],
      ),
    );
  }

  TextTheme _buildTextTheme({required bool isDark}) {
    return TextTheme(
      titleMedium: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: isDark ? Colors.white : Colors.grey[900]),
    );
  }
}
