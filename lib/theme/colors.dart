import 'package:flutter/material.dart';

class C {
  // Yellow brand
  static const yellow = Color(0xFFF5C518);
  static const yellowDeep = Color(0xFFEDB80A);
  static const yellowLight = Color(0xFFFFF9E6);
  static const yellowBg = Color(0xFFFFA500);

  // Neutrals
  static const white = Color(0xFFFFFFFF);
  static const bgPage = Color(0xFFFFFFFF);
  static const bgGray = Color(0xFFF5F5F5);
  static const bgInput = Color(0xFFF7F8FA);
  static const border = Color(0xFFE8E8E8);
  static const divider = Color(0xFFF0F0F0);

  // Text
  static const textDark = Color(0xFF1A1A1A);
  static const textMid = Color(0xFF555555);
  static const textGray = Color(0xFF9CA3AF);
  static const textLight = Color(0xFFBBBBBB);

  // Semantic
  static const green = Color(0xFF22C55E);
  static const red = Color(0xFFEF4444);
  static const blue = Color(0xFF3B82F6);

  // Nav
  static const navActive = Color(0xFFF5C518);
  static const navInactive = Color(0xFFBBBBBB);
}

ThemeData buildTheme() {
  return ThemeData(
    useMaterial3: false,
    fontFamily: 'Nunito',
    scaffoldBackgroundColor: C.bgPage,
    colorScheme: const ColorScheme.light(primary: C.yellow),
    appBarTheme: const AppBarTheme(
      backgroundColor: C.bgPage,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: C.textDark,
        fontSize: 17,
        fontWeight: FontWeight.w700,
        fontFamily: 'Nunito',
      ),
      iconTheme: IconThemeData(color: C.textDark),
    ),
  );
}
