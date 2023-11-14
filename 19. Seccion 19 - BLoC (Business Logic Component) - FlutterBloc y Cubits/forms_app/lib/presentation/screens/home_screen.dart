import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // NOTA: Los Cubits son bastante utilizados, aunque no es tan grande como Flutter BLoC generalmente los usan para
          //       manejar digamos que pequeños estados, pero la vedad podemos usar Cubits en toda la aplicación y va a
          //       funcionar igual de bien.
          ListTile(
            title: const Text('Cubits'),
            subtitle: const Text('Gestor de estado simple'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => context.push('/cubits'),
          )
        ],
      ),
    );
  }
}