import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/presentation/providers/counter_provider.dart';
import 'package:widgets_app/presentation/providers/theme_provider.dart';

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

    // TAREA: Escuchamos el provider definido para cambiar el modo
    // NOTA: Cambiamos esto por nuestro ThemeNotifierProvider
    //final bool isDarkMode = ref.watch(isDarkmodeProvider);
    final bool isDarkMode = ref.watch(themeNotifierProvider).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Screen'),
        actions: [
          //  TAREA: Condicionamos para mostrar un modo u otro.
          IconButton(
            icon: Icon(isDarkMode
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined),
            onPressed: () {
              // TAREA: Cambiamos el estado a su opuesto.
              // NOTA: Acá use la otra forma de usar el read explicada anteriormente para actualizar el counter al presionar el botón de incrementar
              //       y que dejamos comentada, esto lo realice para fines ilustrativos y tener las 2 formas.
              //       Otra cosa es que deje que se llamara state pero facilmente le podemos colocar cualquier otro nombre

              // NOTA: Cambiamos esto por el ThemeNotifierProvider
              // ref.read(isDarkmodeProvider.notifier).update((state) => !state);
              ref.read(themeNotifierProvider.notifier).toggleDarkMode();
            },
          )
        ],
      ),
      body: Center(
        // NOTA: Entonces ya con la referencia al provider lo podemos usar acá para mostrar el valor inicial definido.
        // NOTA: Otra cosa que debemos tener en cuenta es que hay varias formas para esto, por ejemplo podemos envolver
        //       el widget que realmente va a cambiar con un widget llamado Consumer, que es básicamente un builder, con
        //       el cual como su nombre lo indica voy a tener acceso al builder y con ese builder construir lo que necesito.
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
            onPressed: () {
              // NOTA: OJO es mala práctica usar el watch en métodos, entonces acá en lugar de usar el mencionado vamos a usar un read que es para leer
              //       el counterProvider y usamos el notifier para que haga referencia al que se va a encargar de hacer la notificación por decirlo así.
              //       y usar el state y a este sumarle 1 en este caso y para no hacer state = state + 1 pofemos usar el ++ como ya sabemos.
              ref.read(counterProvider.notifier).state++;

              // NOTA: Otra forma con la cual podríamos hacer lo msmo que lo anterior solo que teniendo referencia al state sería la siguiente:
              /*
              ref.read(counterProvider.notifier).update((state) => state + 1);
              */
              //       Y esto solo sería dependiendo de lo que necesitemos ya sea de una forma o de la otra.
            },
          )
        ],
      ),
    );
  }
}
