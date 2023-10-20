import 'package:flutter/material.dart';

class CardsScreen extends StatelessWidget {
  // NOTA: Agreamos una propiedad estática constante para asignar el nombre que luego vamos a usar en el go_router
  //       adicionalmente recordemos que usamos el static para evitar crear instancias de la clase para solo tener
  //       acceso a la propiedad
  static const String name = 'cards_screen';

  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cards Screen'),
      ),
      body: const Placeholder(),
    );
  }
}
