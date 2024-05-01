import 'package:flutter/material.dart';

import 'package:keihi/widgets/expenses.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(
    255, 160, 7, 7,),
);

void main() {
  runApp(
    MaterialApp(
      // theme: ThemeData(useMaterial3: true),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          modalBackgroundColor: Color.fromARGB(255, 220, 163, 176),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: kColorScheme.onSecondaryContainer,
            fontSize: 16,
          ),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 159, 52, 77),
      ),
      home: const Expenses(),
    ),
  );
}