// NOTA: Este archivo que contiene una clase me va a permitir manejar el estilo global de mi aplicación, es decir, si quiero aplicar otros
//       colores a los botones, los textos y demás, esto lo voy a gestionar por acá, adicionalmente me va a ayudar a tener más orden debido
//       a que este theme puede empezar a crecer y a hacer poco legible el código si lo manejamos en nuestro archivo main. También al manejarlo
//       de esta manera también me puede brindar la facilidad de cambiar el tema en tiempo de ejecución.

import 'package:flutter/material.dart';

// NOTA: Creamos un custom Color a partir de un hexadecimal.
//       Ojo algo super importante es que para que Flutter nos permita pasar el color en hexadecimal, siempre
//       tenemos que poner primero 0xFF y luego si el color en hexadecimal deseado.
//
//       OJO Adicionalmente recordemos de las clase de Dart que cuando a una variable le colocamos guion bajo, estamos haciendo
//       privada la propiedad y por consecuencia solo se pueden usar en este archivo.
const Color _customColor = Color(0xFF5C11D4);

// NOTA: Creamos una lista de colores para poder crear o asignar el tema de nuestra app a partir de la lista y así cambiar los colores globalmente
const List<Color> _colorTheme = [
  _customColor,
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.pink,
];

class AppTheme {
  // NOTA: Vamos a crear una propiedad que vamos a recibir desde el padre con el valor del arreglo para asignar el color del tema
  //       y la inicializamos, adicionalmente esto nos va a ser útil para evitar fallos en la app causados porque se envía una posición
  //       que desborde el arreglo, es decir, una opción no permitida y esta validación la vamos a hacer mediante una aserción, y la cual
  //       aprendimos a usar en la introducción a Dart de la sección 2.
  final int selectedColor;

  AppTheme(
      {
      // NOTA: Adicionalmente el colorTheme lo podemos hacer requerido (required) para que nos lo envien o le podemos mandar un valor por defecto que en este caso es cero
      this.selectedColor = 0})
      // NOTA: Como se mencionó antes controlamos al excepción con una aserción
      : assert(selectedColor >= 0 && selectedColor <= _colorTheme.length - 1,
            'Colors must be between 0 and ${_colorTheme.length}');

  // NOTA: Entonces lo que va a tener nuestra clase es un método que regresa algo de tipo ThemeData y la razín es que la propiedad theme
  //       del MaterialApp en nuestro main eso es lo que espera.
  ThemeData theme() {
    return ThemeData(
        // Material 3
        useMaterial3: true,
        // NOTA: Ahora vamos a usar el coloSchemeSeed y que usamos en nuestra primera app y que nos servía para asignar el color del tema y le vamos a pasar
        //       nuestro arreglo de colores personalizado y al cual adicionalmente cambiamos haciendo referencia a través de la posición del arreglo que
        //       recibimos desde el padre.
        colorSchemeSeed: _colorTheme[selectedColor]);
  }
}
