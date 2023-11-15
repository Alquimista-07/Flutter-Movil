// NOTA IMPORTANTE: Der la misma forma que realizamos con cubit el Bloc también lo podemos autogenerar con la exptensión de VS Code llamada Bloc por lo tanto para usarla presionamos Ctrl + Shift + P
//                  y luego buscamos New Bloc, automáticamente nos pide el nombre y la ruta en la que lo queremos crear.
// NOTA: Acá en este archivo tenemos el estado que es como luce el estado propiamente del Bloc, es decir, si tenemos un contador en 1, el número de transacciones, etc. Acá lo tenemos
// NOTA: Adicionalmente acá también podemos usar el Equatable el cual funciona tal cual como se había explicado en el Cubit.
part of 'counter_bloc.dart';

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
