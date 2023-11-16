// NOTA IMPORTANTE: Der la misma forma que realizamos con cubit el Bloc también lo podemos autogenerar con la exptensión de VS Code llamada Bloc por lo tanto para usarla presionamos Ctrl + Shift + P
//                  y luego buscamos New Bloc, automáticamente nos pide el nombre y la ruta en la que lo queremos crear.
// NOTA: Acá en este archivo tenemos el estado que es como luce el estado propiamente del Bloc, es decir, si tenemos un contador en 1, el número de transacciones, etc. Acá lo tenemos
// NOTA: Adicionalmente acá también podemos usar el Equatable el cual funciona tal cual como se había explicado en el Cubit.

// NOTA: Otra cosa es que ¿Cómo hacemos para saber cuando usar Cubit y cuando BLoC? Bueno esto esta a discreción nuestra ya que podemos crear una aplicación entera usando Cubit, pero usuarlmente usariamos
//       BLoC cuando queramos manejar algo más robusto, más estructurado, más fácil de probar también o también estados mayores con BLoC, y con Cubits podriamos manejar pequeños estados.
//       Por ejemplo un formulario lo podemos manejar con Cubit pero el estado global como por ejemplo la autenticación de un usuario la podemos manejar con BLoC, o bien podemos manejar también el estado del
//       formulario con BLoC totalmente sin usar Cubit, y a la larga nosotros somos libres de decidir que sale más fácil, y elegir el gestor de estado que queramos como Provider, Riverpod, Cubit o BLoC, etc.
//       Y como tal no hay un mejor gestor de estado ya que básicamente el mejor gestor de estado en pocas palabra es el que nosotros mejor dominemos y resuelva la necesidad de forma efectiva

part of 'counter_bloc.dart';

// NOTA: Otra cosa es que aunque el Equatable es opcional, es recomendado usarlo ya que esto nos ayuda a hacer más eficiente la aplicación ya que como sabemos con el Equatable comparamos los objetos, y cuando
//       iguales evitamos ejecutar el llamado a eventos o acciones de forma innecesaria.
class CounterState extends Equatable {
  final int counter;
  final int transactionCount;

  const CounterState({
    this.counter = 10,
    this.transactionCount = 0,
  });

  CounterState copyWith({
    int? counter,
    int? transactionCount,
  }) =>
      CounterState(
        counter: counter ?? this.counter,
        transactionCount: transactionCount ?? this.transactionCount,
      );

  @override
  List<Object> get props => [counter, transactionCount];
}
