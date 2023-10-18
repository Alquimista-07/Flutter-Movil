import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        // NOTA: La propiedad brightness me permite asingar un tema en este caso oscuro
        brightness: Brightness.dark,
      );
}
