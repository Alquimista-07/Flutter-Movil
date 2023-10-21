import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  static const name = 'progress_screen';

  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Indicators'),
      ),
      body: const _ProgressView(),
    );
  }
}

class _ProgressView extends StatelessWidget {
  const _ProgressView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          SizedBox(height: 30),
          Text('Circular Progress Indicator'),
          SizedBox(height: 10),
          // NOTA: El widget que vamos a usar el el CircularProgressIndicator
          CircularProgressIndicator(
            strokeWidth: 2,
            // NOTA: El número luego del nombre del color indica la opacidad que este tiene.
            backgroundColor: Colors.black45,
          ),
          SizedBox(height: 20),
          Text('Progress Indicator Controlado Circular y Linear'),
          SizedBox(height: 10),
          _ControllerProgressIndicator()
        ],
      ),
    );
  }
}

class _ControllerProgressIndicator extends StatelessWidget {
  const _ControllerProgressIndicator();

  @override
  Widget build(BuildContext context) {
    // NOTA: Vamos a usar un nuevo widget llamado StreamBuilder y como su nombre lo indica al tener la palabra builder es algo que se va a construir
    //       en timpo de ejecución, y además también como su nombre indica este esta asociado a un Stream que es un flujo de información y que se
    //       explico en la sección 2 de la introducción a Dart.
    return StreamBuilder(
      // NOTA: Entonces para asignar la propiedad stream del StreamBuilder vamos a crear un stream periodico que va a estar emitiendo valores
      //       que cada periodo de tiempo va a estar emitiendo valore que inician desde cero hasta que cancelemos el stream
      stream: Stream.periodic(const Duration(milliseconds: 300), (value) {
        return (value * 2) / 100; // Valores desde 0.0 hasta 1.0
      })
          // NOTA: Ahora yo no quiero que se siga ejecutando hasta el infinito entonces para esto usamos el operador reactivo takeWhile para que se ejecute
          //       hasta que el valor sea menor a 100 y cuando se llegue a 100 se va a cancelar el stream.
          .takeWhile((value) => value < 100),
      builder: (context, snapshot) {
        // NOTA: El snapshot es el que indica cual es el valor propiamiente que tiene el stream
        final progressValue = snapshot.data ??
            0; // SI no tenemos un value va a ser cero y esto es porque la primera emisión va a ser null

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // NOTA: La propiedad value del CircularProgressIndicator y el LinearProgressIndicator es una propiedad de tipo double a la cual le debemos pasar valores
              //       enre 0.0 (ningun valor) y 1.0
              CircularProgressIndicator(
                value: progressValue,
                strokeWidth: 2,
                backgroundColor: Colors.black12,
              ),
              const SizedBox(
                width: 20,
              ),
              // NOTA: Ahora para poder usar el LinearProgressIndicator necesitamos indicarle cual es el espacio
              //       para poder renderizar la línea, de lo contrario si no la indicamos nos va a dar un error.
              //       Adicionalmente como estamos dentro de un Row realmente no tenemos un límite de ancho del
              //       Row y por lo tanto esto causa el error. Entonces para corregir el error usamos el Widget
              //       Expanded el cual le indica que tome todo el espacio que el padre le esta dando
              Expanded(
                  child: LinearProgressIndicator(
                value: progressValue,
              ))
            ],
          ),
        );
      },
    );
  }
}
