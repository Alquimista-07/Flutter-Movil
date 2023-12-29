// NOTA: La idea de este indicador de progreso es que sea algo deivertido y no un simple circular progress indicator
//       Entonces vamos a generar colocar diferentes mensajes en pantalla cada vez que se abra la aplicación y esta
//       este obteniendo información de la API.
import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  // NOTA: Creamos un stream de datos para los mensajes
  Stream<String> getLoadingMessages() {
    // NOTA: Mensajes personalizados.
    final messages = <String>[
      'Cargando películas',
      'Comprando palomitas de maíz',
      'Cargando populares',
      'Llamando a mi novia',
      'Ya mero...',
      'Esto está tardando mucho en cargar :(',
    ];

    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return messages[step];

      // NOTA: Con el take cancelamos la emisión cuando llegue a la cantidad de mensajes
    }).take(messages.length);
  }

  // Constructor
  const FullScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Espere pof favor...'),
          const SizedBox(height: 10),
          const CircularProgressIndicator(strokeWidth: 2),
          const SizedBox(height: 10),
          // NOTA: Para hacer lo de los mensajes vamos a usar un StreamBuilder. Otra cosa genial que hace el StreamBuilder es que cuando ya
          //       se cierra o se termina la emisión automáticamente hace la limpieza por mí y no es necesario que yo mande a llamar el close
          //       del stream
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              // Si aún no hay data
              if (!snapshot.hasData) return const Text('Cargando...');

              return Text(snapshot.data!);
            },
          )
        ],
      ),
    );
  }
}
