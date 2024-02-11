import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'palette.dart';
import 'typography.dart';

// ignore: non_constant_identifier_names
ThemeData dark_theme() => ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateColor.resolveWith((states) => Palette.primary),
        ),
      ),
      drawerTheme: const DrawerThemeData(backgroundColor: Palette.greyDarker),
      primaryColor: Palette.primary,
      primaryColorLight: Palette.primaryAccent,
      appBarTheme: const AppBarTheme(
        backgroundColor: Palette.greyDarker,
        systemOverlayStyle: SystemUiOverlayStyle(
          systemStatusBarContrastEnforced: true,
          statusBarColor: Palette.white,
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.dark, // For iOS (dark icons)
        ),
      ),
      brightness: Brightness.dark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: const TextTheme().apply(
        bodyColor: Palette.greyLight,
        displayColor: Palette.white,
      ),
      scaffoldBackgroundColor: Palette.black,
      primaryTextTheme: textTheme,
      iconTheme: const IconThemeData(color: Palette.greyLight),
      colorScheme: const ColorScheme.dark().copyWith(background: Palette.black),
    );
