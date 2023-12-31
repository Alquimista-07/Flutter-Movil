// NOTA IMPORTANTE: Der la misma forma que realizamos con cubit el Bloc también lo podemos autogenerar con la exptensión de VS Code llamada Bloc por lo tanto para usarla presionamos Ctrl + Shift + P
//                  y luego buscamos New Bloc, automáticamente nos pide el nombre y la ruta en la que lo queremos crear.
// NOTA: Este archivo bloc es similar al del Cubit, es la misma idea básicamente que maneja el state, solo que va a fluir de una manera un poco deiferente, pero acá tenemos nuestro

// NOTA: Otra cosa es que ¿Cómo hacemos para saber cuando usar Cubit y cuando BLoC? Bueno esto esta a discreción nuestra ya que podemos crear una aplicación entera usando Cubit, pero usuarlmente usariamos
//       BLoC cuando queramos manejar algo más robusto, más estructurado, más fácil de probar también o también estados mayores con BLoC, y con Cubits podriamos manejar pequeños estados.
//       Por ejemplo un formulario lo podemos manejar con Cubit pero el estado global como por ejemplo la autenticación de un usuario la podemos manejar con BLoC, o bien podemos manejar también el estado del
//       formulario con BLoC totalmente sin usar Cubit, y a la larga nosotros somos libres de decidir que sale más fácil, y elegir el gestor de estado que queramos como Provider, Riverpod, Cubit o BLoC, etc.
//       Y como tal no hay un mejor gestor de estado ya que básicamente el mejor gestor de estado en pocas palabra es el que nosotros mejor dominemos y resuelva la necesidad de forma efectiva

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  // NOTA: Lo que tenemos acá se ve un poco extraño, pero básicamente lo que tenemos acá es un constructor, el cual llama al super e inicializa el estado (Counterstate)
  CounterBloc() : super(const CounterState()) {
    // NOTA: Luego lo que tenemos acá dentro es el cuerpo del constructor y dentro de este se esta definiendo un handler o manejador de un counter event, el cual se autogenera y básicamente es una guía
    //       de como tenemos que implementar, entonces lo que vamos a hacer es usar nuestro evento increased
    on<CounterIncreased>(_onCounterIncreased);

    //* Tarea: Handler del evento para el reset
    on<CounterReset>(_onCounterReset);

    // NOTA: La línea de código anterior es la misma que la siguiente, y esto es porque al tener la misma cantidad de argumentos lo podemos simplificar mandando la referencia a la función
    //       de esa manera y obviamos mandar los argumentos.
    /*
      on<CounterIncreased>((event, emit) => _onCounterIncreased(event, emit));
    */

    // NOTA: Por lo tanto al tener los handler separados de esta manera podemos tener un montón de ellos para ser llamados y tener un poco de orden
  }

  void _onCounterIncreased(CounterIncreased event, Emitter<CounterState> emit) {
    // NOTA: Y cuando el counter sea incrementado, voy a hacer literalmente lo mismo que realizamos cuando implementamos Cubit
    emit(state.copyWith(
      // NOTA: Ahora ¿Cómo se yo cual es el valor a incrementar?
      //       Entonces como el evento que se esta disparando es el CounterIncreased, el evento sabe que es de tipo CounterIncreased, eso significaria que el event tiene el value que se le especifico
      //       cuando se creo el evento en nuestro archivo counter_event
      counter: state.counter + event.value,
      transactionCount: state.transactionCount + 1,
    ));
  }

  //* Tarea: Reset
  void _onCounterReset(CounterReset event, Emitter<CounterState> emit) {
    emit(state.copyWith(
      counter: 0,
    ));
  }

  // NOTA: Hay persona que hacen esto para que en lugar de que el widget se encargue de llamar el evento lo que se hace es
  //       centralizar la forma como voy a incrementar el counter bloc
  void increaseBy([int value = 1]) {
    add(CounterIncreased(value));
  }

  // NOTA: Y se hace lo mismo con el reset
  void resetCounter() {
    add(CounterReset());
  }
}
