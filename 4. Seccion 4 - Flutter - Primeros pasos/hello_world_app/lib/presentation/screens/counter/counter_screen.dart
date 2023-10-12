// NOTA: El shortcut para importar rápido el paquete de material es: impm
import 'package:flutter/material.dart';

// EL shortcut para crear rápido el statless widget es: stless
// y esto ya nos crea la estructura inicial que tenemos que tener y que vamos a modificar
class CounterScreen extends StatelessWidget {
  // Constructor
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Agregamos el appBar para poner el título en la aplicación
      appBar: AppBar(
        title: const Text('Counter Screen'),
      ),
      // NOTA: Hay muchos widgets que solo tienen un hijo pero hay algunos widgets que también reciben
      //       múltpiles hijos y los cuales podemos revisar algunos en la hoja de atahos de Flutter.
      //       Entonces quitamos el widget Text y ahora vamos a usar otro widget que recibe múltpiles hijos.
      //body: Center(child: Text('Counter Screen!!!...')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .center, // Esta propiedad MainAxisAlignment es similar a Flexbos Grid en web, es decir, sirve para ubicar el widget o widgets dentro de la pantalla.
          children: [
            Text(
              '10',
              style: TextStyle(fontSize: 160, fontWeight: FontWeight.w100),
            ),
            Text(
              'Cantidad de clicks',
              style: TextStyle(fontSize: 25),
            )
          ],
        ),
      ),
      // Colocamos el botón flotante, y esto recordando que en la hoja de ruta de Flutter vemos que el Scaffold es una interfaz en la cual podemos implementar botones
      // flotantes entre otras cosas. Entonces creamos un FloatinAction Button el cual necesita el método onPressed y a este le vamos a mandar una función
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        // Y el child del floatinActionButton recibe otro widget, cual quier widget es decir puede ser un texto, otor botón, lo que sea. En este caso es un Icon el cual es otro widget
        // que recibe el Icons.plus_one (conocido como IconData) que es el ícono que queremos mostrar
        child: const Icon(Icons.plus_one),
      ),
    );
  }
}
