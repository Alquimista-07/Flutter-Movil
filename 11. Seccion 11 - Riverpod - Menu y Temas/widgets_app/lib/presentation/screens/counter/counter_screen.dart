import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/presentation/providers/counter_provider.dart';

// NOTA: Ahora como estamos usando Riverpod es necesario cambiar el StatelessWidget por un ConsumerWidget el cual nos ofrece en
//       el método build la referencia al WidgetRef que es básicamente decirle a Riverpod Hey! voy a ocupar la referencia a algún
//       provider, pero que provider? eso no importa ya que nosotros lo vamos a epecificar en el método watch() y eso es literlamente
//       todo, y es bien bien fácil
class CounterScreen extends ConsumerWidget {
  static const name = 'counter_screen';

  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // NOTA: Entonces como se mencionó anteriormente vamos a pasar el provider, y sobre el cual se va a estar pendiente cada vez que cambie
    //       y cada vez que cambie voy a tener el valor y Flutter va a redibujar el widget donde sea necesario
    final int clickCounter = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Screen'),
      ),
      body: Center(
        // NOTA: Entonces ya con la referencia al provider lo podemos usar acá para mostrar el valor inicial definido.
        child: Text(
          'Valor: $clickCounter',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
