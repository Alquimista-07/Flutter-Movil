import 'package:flutter/material.dart';
import 'package:widgets_app/config/theme/app_theme.dart';
import 'package:widgets_app/presentation/screens/buttons/buttons_screen.dart';
import 'package:widgets_app/presentation/screens/cards/cards_screen.dart';
import 'package:widgets_app/presentation/screens/home/home_screend.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 5).getTheme(),
      home: const HomeScreen(),
      // NOTA: Esto hace parte de la segunda forma que se explico de como hacer navegación entre pantallas y que se codifico en el home_screend.dart
      // NOTA: Acá podemos definir las rutas como se haría en web pero esto tiene una limitante, ya que por ejemplo no podemos mandar argumentos
      //       y por lo tanto aunque podemos hacerlo así existen mejores formas de hacer esto como el go_router, que lo veremos más
      //       adelante, pero de momento esto es para fines ilustrativos.
      routes: {
        '/buttons': (context) => const ButtonsScreen(),
        '/cards': (context) => const CardsScreen(),
      },
    );
  }
}
