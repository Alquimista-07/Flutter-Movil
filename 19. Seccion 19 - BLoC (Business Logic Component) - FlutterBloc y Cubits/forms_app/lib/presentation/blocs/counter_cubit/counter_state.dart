//NOTA: BLoC es una forma de trabajar el estado de la aplicación separado en eventos, separado en estado y separado en una clase que controla los
//      eventos y los estados. Por lo tanto Flutter BLoC es la implementación de BLoC en Flutter por lo tanto este tiene widgets, provider y demás
//      para su uso e implementación. Adicionalmente este al ser un paquete necesita ser instalado por lo tanto la documentación la podemos encontrar
//      en: https://pub.dev/packages/flutter_bloc
//      Otra cosa que hay que tener en cuenta que al instalar Flutter BLoC automáticamente también nos instala los Cubits

// NOTA IMPORTANTE: Estos cubit los podemos autogenerar con la exptensión de VS Code llamada Bloc por lo tanto para usarla presionamos Ctrl + Shift + P
//                  y luego buscamos New Cubit, automáticamente nos pide el nombre y la ruta en la que lo queremos crear.
part of 'counter_cubit.dart';

// NOTA: Acá quitmos la anotación @inmutable ya que esto era parte de versiones anteriores de Dart y esto es porque una clase abstracta ya es inmutable.
// NOTA: Ahora en el estado tenemos un clase abstracta porque podemos emitir diferentes estados, en este caso vamos a modificar lo que se nos había autogenerado
//       para crear nuestra propia clase

class CounterState {
  // NOTA: Acá definimos como queremos que luzca nuestro estado
  final int counter;
  final int transactionCount; // Número de veces que ha cambiado el counter

  CounterState({
    this.counter = 0,
    this.transactionCount = 0,
  });

  // NOTA: Una vez creado nuestro estado es conveniente que nosotros nos creemos una forma de emitir un nuevo
  //       estado, de crearnos una copia de este estado, y esto es conveniente porque vamos a estar emitiendo
  //       nuevos estados básicamente un nuevo va a ser una nueva instancia de este estado
  copyWith({
    int? counter,
    int? transactionCount,
  }) =>
      CounterState(
        counter: counter ?? this.counter,
        transactionCount: transactionCount ?? this.transactionCount,
      );
}
