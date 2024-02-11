import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'palette.dart';
import 'typography.dart';

// ignore: non_constant_identifier_names
ThemeData light_theme() => ThemeData(
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          systemStatusBarContrastEnforced: true,
          statusBarColor: Palette.white,
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.dark, // For iOS (dark icons)
        ),
      ),
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: const TextTheme().apply(fontFamily: GoogleFonts.openSans().fontFamily, displayColor: Colors.black),
      primaryTextTheme: textTheme,
      scaffoldBackgroundColor: Palette.white,
      iconTheme: const IconThemeData(color: Palette.greyDark),
      fontFamily: GoogleFonts.openSans().fontFamily,
    );
