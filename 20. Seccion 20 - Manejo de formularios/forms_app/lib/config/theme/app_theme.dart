import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() {
    const seedColor = Colors.deepPurple;

    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: seedColor,
      // NOTA: Definimos un color por defecto para las listas y no tenerlo que estar definiendo cada vez que lo necesitemos
      listTileTheme: const ListTileThemeData(
        iconColor: seedColor,
      ),
    );
  }
}
