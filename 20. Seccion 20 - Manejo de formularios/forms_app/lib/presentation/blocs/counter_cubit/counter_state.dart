//NOTA: BLoC es una forma de trabajar el estado de la aplicación separado en eventos, separado en estado y separado en una clase que controla los
//      eventos y los estados. Por lo tanto Flutter BLoC es la implementación de BLoC en Flutter por lo tanto este tiene widgets, provider y demás
//      para su uso e implementación. Adicionalmente este al ser un paquete necesita ser instalado por lo tanto la documentación la podemos encontrar
//      en: https://pub.dev/packages/flutter_bloc
//      Otra cosa que hay que tener en cuenta que al instalar Flutter BLoC automáticamente también nos instala los Cubits

// NOTA IMPORTANTE: Estos cubit los podemos autogenerar con la exptensión de VS Code llamada Bloc por lo tanto para usarla presionamos Ctrl + Shift + P
//                  y luego buscamos New Cubit, automáticamente nos pide el nombre y la ruta en la que lo queremos crear.

// NOTA: Otra cosa es que ¿Cómo hacemos para saber cuando usar Cubit y cuando BLoC? Bueno esto esta a discreción nuestra ya que podemos crear una aplicación entera usando Cubit, pero usuarlmente usariamos
//       BLoC cuando queramos manejar algo más robusto, más estructurado, más fácil de probar también o también estados mayores con BLoC, y con Cubits podriamos manejar pequeños estados.
//       Por ejemplo un formulario lo podemos manejar con Cubit pero el estado global como por ejemplo la autenticación de un usuario la podemos manejar con BLoC, o bien podemos manejar también el estado del
//       formulario con BLoC totalmente sin usar Cubit, y a la larga nosotros somos libres de decidir que sale más fácil, y elegir el gestor de estado que queramos como Provider, Riverpod, Cubit o BLoC, etc.
//       Y como tal no hay un mejor gestor de estado ya que básicamente el mejor gestor de estado en pocas palabra es el que nosotros mejor dominemos y resuelva la necesidad de forma efectiva

part of 'counter_cubit.dart';

// NOTA: Acá quitmos la anotación @inmutable ya que esto era parte de versiones anteriores de Dart y esto es porque una clase abstracta ya es inmutable.
// NOTA: Ahora en el estado tenemos un clase abstracta porque podemos emitir diferentes estados, en este caso vamos a modificar lo que se nos había autogenerado
//       para crear nuestra propia clase

class CounterState extends Equatable {
  // NOTA: Acá definimos como queremos que luzca nuestro estado
  final int counter;
  final int transactionCount; // Número de veces que ha cambiado el counter

  const CounterState({
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

// NOTA: Aunque el object lo podemos dejar opcional <Object?> esto es solo si tenemos propiedades que pueden llegar a ser nular
//       y este no es el caso de nuestro ejercicio entonces le quitamos el ?
  @override
  List<Object> get props => [counter, transactionCount];
}
