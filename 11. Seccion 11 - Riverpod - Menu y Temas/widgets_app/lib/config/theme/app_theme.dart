import 'package:flutter/material.dart';

const colorList = <Color>[
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.red,
  Colors.purple,
  Colors.deepPurple,
  Colors.orange,
  Colors.pink,
  Colors.pinkAccent,
];

class AppTheme {
  final int selectedColor;
  final bool isDarkMode;

  AppTheme({this.selectedColor = 0, this.isDarkMode = false})
      : assert(selectedColor >= 0, 'Selected color must be greater than 0'),
        assert(selectedColor < colorList.length,
            'Selected color must be less or equal than ${colorList.length - 1}');

  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      // NOTA: Ahora la propieada brightness es la que nos permite colocar el modo claro u obscuro
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      colorSchemeSeed: colorList[selectedColor],
      // NOTA: Configuración global para todos los appBar
      appBarTheme: const AppBarTheme(
          // NOTA: Mantenemos el titulo del appBar siempre alineado a la izquierda sin importar si es en IOS o Android
          centerTitle: false));

  // NOTA: Ahora voy a crearme un método que va a regresar una instancia del AppTheme
  //       Y este nos sirve para copiar la clase y expandir sus funcionalidades si así
  //       lo deseamos. Entonces por lo tanto vamos a pasar las propiedades que necesitamos
  //       solo que van a ser opcionales
  AppTheme copyWith({
    int? selectedColor,
    bool? isDarkmode,
  }) =>
      AppTheme(
          selectedColor: selectedColor ?? this.selectedColor,
          isDarkMode: isDarkmode ?? isDarkMode);
}
