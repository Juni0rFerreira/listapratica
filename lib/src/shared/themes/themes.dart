import 'package:flutter/material.dart';
part 'color_schemes.g.dart';

ThemeData get lightTheme => ThemeData(
      useMaterial3: true,
      colorScheme: _lightColorScheme,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: _lightColorScheme.primaryContainer,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(12))),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: _lightColorScheme.primary,
          foregroundColor: _lightColorScheme.onPrimary),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.resolveWith<TextStyle?>((states) {
            if (states.contains(MaterialState.selected)) {
              return const TextStyle(fontSize: 9);
            }
            return const TextStyle(fontSize: 12);
          }),
        ),
      ),
      listTileTheme:
        ListTileThemeData(iconColor: _darkColorScheme.primaryContainer)
    );

ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    colorScheme: _darkColorScheme,
    appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: _darkColorScheme.primaryContainer,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)))),
    segmentedButtonTheme: SegmentedButtonThemeData(style: ButtonStyle(
        textStyle: MaterialStateProperty.resolveWith<TextStyle?>((states) {
      if (states.contains(MaterialState.selected)) {
        return const TextStyle(fontSize: 9);
      }
      return const TextStyle(fontSize: 12);
    }))),
    listTileTheme:
        ListTileThemeData(iconColor: _darkColorScheme.onPrimaryContainer));
