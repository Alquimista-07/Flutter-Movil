import 'package:flutter/material.dart';

class SnackbarScreen extends StatelessWidget {
  static const name = 'snackbar_screen';

  const SnackbarScreen({super.key});

  void showCustomSnackbar(BuildContext context) {
    // NOTA: Para mostrar el Snackbar para comenzar todo empieza con el Scaffold() y hay varias formas de mostrar Snackbars
    //       por ejemplo podemos tener el key en el Scaffold() y ese key es el que me va a aydar a ubicar ese Scaffold() pero
    //       hay otra forma en la cual no importa donde nos encontremos yo le puede decir a Flutter que trate de encontrar
    //       el Scaffold() más cercano y ahí construye el Snackbar. Entonces en este caso lo vamos a hacer de la segunda forma
    //       que es diciendole que busque el más cercano, entonces para ello vamos a hacer lo siguiente:

    // NOTA: Con el clearSnackbars hacemos que una vez se este mostrando un snackbar y si mandamos a llanar nuevamente otro snackbar
    //       este no quede encolado y si llamamos varias veces el snackbar vaya a quedar apareciendo dureante un tiempo dando la impresión
    //       de que la app se trabo, entonces para eso usamos ese clearSnackbars para que esto no suceda y una vez mandamos a llamar
    //       nuevamente un snackbar el anterior se limpie.
    ScaffoldMessenger.of(context).clearSnackBars();

    final snackbar = SnackBar(
      content: const Text('Hola Mundo!!!...'),
      // NOTA: Por ejemplo también al snackbar podemos agregarle un action
      action: SnackBarAction(label: 'OK', onPressed: () {}),
      // NOTA: También podemos agregar el tiempo de duración que se va a estar mostrando
      duration: const Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbars y Diálogos'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Mostrar Snackbar'),
        icon: const Icon(Icons.remove_red_eye_outlined),
        onPressed: () => showCustomSnackbar(context),
      ),
    );
  }
}
