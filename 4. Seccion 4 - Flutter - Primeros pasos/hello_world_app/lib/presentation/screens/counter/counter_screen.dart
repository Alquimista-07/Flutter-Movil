// NOTA: El shortcut para importar rápido el paquete de material es: impm
import 'package:flutter/material.dart';

// EL shortcut para crear rápido el statless widget es: stless
// y esto ya nos crea la estructura inicial que tenemos que tener y que vamos a modificar
class CounterScreen extends StatelessWidget {
  // Constructor
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Counter Screen!!!...')),
    );
  }
}
