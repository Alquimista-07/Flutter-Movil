import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/counter_cubit/counter_cubit.dart';

class CubitCounterScreen extends StatelessWidget {
  const CubitCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //NOTA: Para usar el CounterCubit es literalmente igual a como nosotros usamos el primer gestor de estado que vimos que es Provider
    //      es idéntico. Adicionalmente dependiendo del alcance que le queramos dar al provider lo colocamos en ese archivo, por ejemplo
    //      colocarlo en el main indicaría que queremos que este disponible para toda la aplicación y por lo tanto todos los widgets van
    //      a tener acceso a ese Cubit, en este caso nuestro CounterCubit solo va a vivir en la pantalla de cubit_counter_screen.
    //      Entonces necesito envolver todos los widgets que pueden tener acceso a ese estado del Cubit en un Bloc Provider que es igual
    //      al MultiProvider que usamos anteriormente, inclusive tenemos ese mismo MultiBlocProvider y todo lo demás.
    return BlocProvider(
      // NOTA: Este pide la propiedad create que recibe el BuildContext que no lo voy a usar entonces lo dejamos con _ y este tiene que
      //       regresar la instancia del Cubit
      create: (_) => CounterCubit(),
      child: const _CubitCounterView(),
    );
  }
}

// NOTA: Por lo tanto como envolvimos esto en el BlocProvider entonces en todo lado de acá vamos a poderlo usar
class _CubitCounterView extends StatelessWidget {
  const _CubitCounterView();

  @override
  Widget build(BuildContext context) {
    //------------------------------
    // Segunda forma
    //------------------------------
    // NOTA: Para llevar la cuenta del Cubit Counter: vamos a hacerlo de una segunda forma que es la forma tradicional
    //       que a muchos les gusta y es que acá en el método build tenemos otra forma en la que nosotros podemos estar escuchando los cambios
    //       que tiene el state. Y es similar a Riverpod, adicionalmente también a parte del state tenemos acceso a los
    //       métodos como por ejemplo el increasedBy.
    //       Otra cosa es que recordemos que el watch cuando el state cambie va a volver a redibujar
    final counterState = context.watch<CounterCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cubit Counter: ${counterState.transactionCount}'),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.refresh_outlined),
          ),
        ],
      ),
      body: Center(
        //------------------------------
        // Primera forma
        //------------------------------
        // NOTA: Este nuevo widget a pesar de que dice Bloc pero estamos con Cubit pero los Cutis son básicamente Blocs nos va a dar acceso al estado
        //       para usarlo, adicionalmente Cubits y BLoC es bastante eficiente ya que este solo redibuja el widget que esta cambiando a diferencia de
        //       Riverpod que aunque no redibuja todo este pasa por un procedo de validaciones para redibujar solo lo que cambio y de una u otra manera
        //       esto hace eficiente a Riverpod pero como se menciono este pasa por ese proceso de validaciones cosa que BloC y Cubits no lo hace y es otra
        //       de las razones por las cuales a muchos les gusta trabajar con él.
        child: BlocBuilder<CounterCubit, CounterState>(
          // NOTA: En teoría si lo dejamos solo con el builder podría verse que el state cambia muchas veces, pero nosotros podemos inclusive venir acá y definir
          //       la propiedad buildWhen para contruirlo únicamente cuando el valor del counter cambie, es decir cuando el valor actual del counter sea diferente
          //       a su valor anterior y esto es una forma de hacerlo eficiente. Pero incluso existe una manera de evitar que colocar esta condiciones o validaciones
          //       si el estado no cambia, por lo tanto dejamos comentada esta línea
          //buildWhen: (previous, current) => current.counter != previous.counter,
          builder: (context, state) {
            return Text('Counter value: ${state.counter}');
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            // NOTA: Este heroTag es para cuando tenemos más de un FloatingActionButton, ocupamos decirle a Flutter cual es el
            //       FloatingActionButton que se anima por defecto entre Scaffolds
            heroTag: '1',
            child: const Text('+3'),
            onPressed: () => {},
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
            heroTag: '2',
            child: const Text('+2'),
            onPressed: () => {},
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
            heroTag: '3',
            child: const Text('+1'),
            onPressed: () => {},
          ),
        ],
      ),
    );
  }
}
