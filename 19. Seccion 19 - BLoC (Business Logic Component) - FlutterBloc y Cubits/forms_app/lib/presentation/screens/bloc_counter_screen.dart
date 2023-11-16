// NOTA: Para consumir el Bloc es muy muy muy similar a Cubit y la llamada de los métodos es idéntica
//       pero usualmente cuando nosotros queremos un cambio en el estado emitimos un evento y esa es la
//       diferencia.
//       Por lo tanto al ser similar a Cubit la forma de consumir y leer los valores con el read, el watch y demás
//       cosas que vimos en Cubit son iguales
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/counter_bloc/counter_bloc.dart';

class BlocCounterScreen extends StatelessWidget {
  const BlocCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // NOTA: De la misma forma que Cubit tengo que envolver los widget dentro del provider para tener acceso
    //       a la instancia del BLoC. Adicionalmente este provider tiene el context pero en este caso no lo
    //       necesito entonces lo dejo con _
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: const BlocCounterView(),
    );
  }
}

class BlocCounterView extends StatelessWidget {
  const BlocCounterView({
    super.key,
  });

  void increasedCounterBy(BuildContext context, [int value = 1]) {
    // NOTA: Como no creamos un método increasedBy del lado del Bloc como teniamos con el Cubit acá vamos es a usar el método
    //       .add() el cual me permite disparar un evento y el cual en nuestro BLoC si tenemos un evento.

    //context.read<CounterBloc>().add(CounterIncreased(value));

    // NOTA: Entonces como creamos los métodos en el counter_bloc para centralizar simplemente comentamos lo anterior y acá usamos
    //       esos métodos.
    context.read<CounterBloc>().increaseBy(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //* Tarea: Mostrar número de transacciones
        title: context.select(
          (CounterBloc counterBloc) =>
              Text('BLoC Counter: ${counterBloc.state.transactionCount}'),
        ),
        actions: [
          IconButton(
            //* Tarea: Llamar el método para el reset
            // NOTA: Acá podemos hacerlo directamente con el read y no tener que crear un método aparte
            // onPressed: () => context.read<CounterBloc>().add(CounterReset()),

            // NOTA: Entonces como creamos los métodos en el counter_bloc para centralizar simplemente comentamos lo anterior y acá usamos
            //       esos métodos.
            onPressed: () => context.read<CounterBloc>().resetCounter(),
            icon: const Icon(Icons.refresh_outlined),
          ),
        ],
      ),
      body: Center(
        child: context.select(
          (CounterBloc counterBlock) =>
              Text('Counter value: ${counterBlock.state.counter}'),
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
            onPressed: () => increasedCounterBy(context, 3),
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
            heroTag: '2',
            child: const Text('+2'),
            onPressed: () => increasedCounterBy(context, 2),
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
            heroTag: '3',
            child: const Text('+1'),
            onPressed: () => increasedCounterBy(context),
          ),
        ],
      ),
    );
  }
}
