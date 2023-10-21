import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

// NOTA: Creamos una ventana de dialogo personalizado ya que el showAboutDialog es algo genérico
  void openDialog(BuildContext context) {
    showDialog(
      context: context,
      // NOTA: Con la propiedad barrierDismissible podemos evitar que el diálogo se cierre cuando toquemos fuera de este y obliguemos a que tiene que
      //       presionar alguno de los botones de aceptar o cancelar
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('¿Estás seguro?'),
        content: const Text(
            'Est est dolor veniam duis magna labore exercitation et consectetur dolore cillum. Incididunt nulla sit culpa excepteur est enim eu aliqua mollit incididunt eiusmod ad aute. Ex dolor consectetur veniam commodo cupidatat. Elit elit laborum et minim et dolor duis ea occaecat. Duis nostrud exercitation proident irure veniam esse aliqua.'),
        actions: [
          TextButton(
            // NOTA: Gracias al go_router podemos usar el método pop de lo contario tendríamos que hacerlo con el Navigator
            onPressed: () => context.pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => context.pop(),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbars y Diálogos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: () {
                // NOTA: El showAboutDialog es propio de Flutter y nos ayuda a mostrar todas las licencias de software que estamos usando en nuestra
                //       aplicación de una forma rápida y sin escribir demasiao código.
                showAboutDialog(
                  context: context,
                  children: [
                    const Text(
                        'Qui mollit duis ex irure Lorem. Ut adipisicing voluptate laborum consequat ipsum enim do est ea occaecat laboris ipsum. Sint deserunt in mollit eiusmod. Est occaecat nulla dolor pariatur officia nostrud occaecat est. Officia amet eiusmod ex nulla officia aliquip.')
                  ],
                );
              },
              child: const Text('Licencias Usadas'),
            ),
            FilledButton(
              onPressed: () => openDialog(context),
              child: const Text('Mostrar Diálogo'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Mostrar Snackbar'),
        icon: const Icon(Icons.remove_red_eye_outlined),
        onPressed: () => showCustomSnackbar(context),
      ),
    );
  }
}
