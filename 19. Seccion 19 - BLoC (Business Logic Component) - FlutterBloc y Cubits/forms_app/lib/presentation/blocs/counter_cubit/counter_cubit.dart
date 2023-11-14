//NOTA: BLoC es una forma de trabajar el estado de la aplicación separado en eventos, separado en estado y separado en una clase que controla los
//      eventos y los estados. Por lo tanto Flutter BLoC es la implementación de BLoC en Flutter por lo tanto este tiene widgets, provider y demás
//      para su uso e implementación. Adicionalmente este al ser un paquete necesita ser instalado por lo tanto la documentación la podemos encontrar
//      en: https://pub.dev/packages/flutter_bloc
//      Otra cosa que hay que tener en cuenta que al instalar Flutter BLoC automáticamente también nos instala los Cubits
// NOTA IMPORTANTE: Estos cubit los podemos autogenerar con la exptensión de VS Code llamada Bloc por lo tanto para usarla presionamos Ctrl + Shift + P
//                  y luego buscamos New Cubit, automáticamente nos pide el nombre y la ruta en la que lo queremos crear.

// NOTA: Acá cambioamos la importación (import 'package:bloc/bloc.dart';) por la de flutter bloc ya que no tenemos bloc y además es porque Flutter Bloc ya contiene
//       Bloc.
import 'package:flutter_bloc/flutter_bloc.dart';

// NOTA: Acá quitamos el (import 'package:meta/meta.dart') ya que como quitamos el @inmutable en el state entonces ya no es necesario, además porque una clase
//       abstracta ya es inmutable.

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState(counter: 5));

  // NOTA: Una cosa genial de este CounterCubit que podríamos asimilarlo como si fuera un Provider, es decir, podemos verlo como si fuera algo similar.
  //       Nosotros podemos tener métodos, propiedades, propiedades propias del Cubit que no están amarradas al estado (CounterState), por ejemplo strings
  //       listeners o recibir información proveniente de otro Cubit, etc. Es decir, podemos tener muchas otras cosasa que están desenlazadas del estado.

  //       Por lo tanto acá vamos a tener un método que se va a encargar de incrementar el valor del estado dependiendo del valor que le mandemos.
  //       Pero técicamente el nombre no es cambiar el estado ya que el estado es inmutable debido a que son final y por lo tanto no puedo venir
  //       acá y decir state.counter = 10; y yo no puedo mutar el estado y es una de las cosas que les gusta a la gente que trabaja con BLoC ya que
  //       al ser inmutable vamos a tener un mejor control, saber cual era el estado anterior, etc porque el estao no es mutable.
  void increaseBy(int value) {
    //     Entonces ¿Qué hago yo si quiero emitir un nuevo estado?
    //     Entonces vamos a llamar un emit y técnicamente dentro de ese método tener el CounterState(), usaar sus propiedades y hacer la emisión respectiva.
    //     Pero sería tedioso tener que hacer que las propiedades counter: state.counter + value y transactionCount: state.transaction + 1. Entonces para esto
    //     creamos nuestro copyWith() y funciona exáctemente igual que si hicieramos lo mencionado anterioemte, adicionalmente las propiedades no van a ser
    //     obligatorias ya que así lo definimos para que si no mandamos una propiedad tome el valor actual de ese estado
    emit(state.copyWith(
      counter: state.counter,
      transactionCount: state.transactionCount + 1,
    ));
  }

  // Vamos a tener otro método que va a resetear el estado
  void reset() {
    emit(state.copyWith(
      counter: 0,
    ));
  }
}
