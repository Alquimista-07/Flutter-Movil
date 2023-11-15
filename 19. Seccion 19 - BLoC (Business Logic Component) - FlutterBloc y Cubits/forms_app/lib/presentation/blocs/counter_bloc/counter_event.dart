// NOTA IMPORTANTE: Der la misma forma que realizamos con cubit el Bloc también lo podemos autogenerar con la exptensión de VS Code llamada Bloc por lo tanto para usarla presionamos Ctrl + Shift + P
//                  y luego buscamos New Bloc, automáticamente nos pide el nombre y la ruta en la que lo queremos crear.
// NOTA: Dentro de este archivo tenemos tenemos que para emitir nuevos estados, se hace basado en eventos, es similar a la idea de Redux si ya hemos trabajado con Redux antes, en los cuales las
//       modificaciones se hacen basado en eventos, es decir, llamamos un evento por ejemplo llamado incrementar, el cual al llamar ese evento incrementar lo recibe el Bloc y el Bloc sabe que hacer
//       cuando recibe un evento de ese tipo, entonces es como más controlado.
// NOTA: El counter event es muy útil porque nos permite a nosotros poder decir que tipos de eventos mi Bloc va a recbir
part of 'counter_bloc.dart';

abstract class CounterEvent {
  const CounterEvent();
}

// NOTA: Eventualmente yo voy a crear un nuevo evento que se va a llamar CounterIncreased y usualmente lo colocan en pasado porque quiere decir que ya sucedió y es un estándar aunque podemos llamarlo como
//       queramos, y este va a extender del event (CounterEvent) y notemos que el CounterEvent es abstracto, es decir, que yo no puedo crear instancias de este, pero si me sirve para extenderlo.
//       Ahora si el counter cambió, es decir, incrementó me gustaría saber con que valor incrementó, es decir, me gustaría saber el valor con el cual yo voy a incrementar el contador
class CounterIncreased extends CounterEvent {
  final int value;

  const CounterIncreased(this.value);
}

//* Tarea: Evento para el reset
class CounterReset extends CounterEvent {}
