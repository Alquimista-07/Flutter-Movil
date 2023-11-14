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
      //       regresar la instancia del Cubit.
      //       OJOOOOOOOOOOOOOOO hay que tener en cuenta con Cubit es que tiene una limitante ya que si ocuparamos tener más de uno tendriamos que
      //       ingeniarnosla para mantenerlos y ese es el inconveniente que tiene y el cual ese si lo resuelve Riverpod sin ningún problema, ya que por
      //       ejemplo cuando realizamos el context.select para el Cubit Counter donde tenemos el transactionaCounter este va a retornar la primer
      //       instancia en el build Context de ese Cubit cosa que puede ser un problema ya que por ejemplo en la aplicación de cinemapedia teniamos
      //       el mismo provider pero cambiaba el estado y el nombre y esta es una de las limitante en general el Provider y no es de BLoC ni FlutterBloc
      //       y esto es una consideración pero no signigica que no se pueda trabajar y no quiere decir que no nos la podamos ingeniar para tener más de una
      //       instancia de una clase que haga cosas similares.
      create: (_) => CounterCubit(),
      child: const _CubitCounterView(),
    );
  }
}

// NOTA: Por lo tanto como envolvimos esto en el BlocProvider entonces en todo lado de acá vamos a poderlo usar
class _CubitCounterView extends StatelessWidget {
  // NOTA: Para evitar repetir código y hacerlo más legible vamos a crear un método
  //       que reciba el context y el valor opcional que si no se define el valor por
  //       defecto es 1
  void increaseCounterBy(BuildContext context, [int value = 1]) {
    context.read<CounterCubit>().increaseBy(value);
  }

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
    // final counterState = context.watch<CounterCubit>().state;

    return Scaffold(
      appBar: AppBar(
        //------------------------------
        // Tercera forma
        //------------------------------
        // NOTA: Tenemos otra forma para que en vez de estar escuchando con el watch los cambios ya que con el watch vamos al context y estamos evaluando
        //       todos los widgets y decirle a Flutter que verifique los widgets si algo cambió y si no use la misma instancia y Flutter es muy eficiente
        //       en esto. Pero la verdad si no es necesario que yo tome la referencia al whatch puedo hacerlo aún más eficiente e ir simplemente a donde
        //       necesito el cambio del state y usar otro BLoC Builder y si quiero estar pendiente de un BLoC podemos usar el select que pide un value y la
        //       función, donde el value es literalmente un objeto que va a ser el objeto que me interesa buscar que sería en este caso el CounterCubit.
        //       Por lo tnato esto que colocamos acá es literlamente igual a todo lo que colocamso en la Primera forma donde tenemos el Counter value:
        title: context.select((CounterCubit value) {
          return Text('Cubit Counter: ${value.state.transactionCount}');
        }),

        actions: [
          IconButton(
            onPressed: () {
              context.read<CounterCubit>().reset();
            },
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
          //       si el estado no cambia, por lo tanto dejamos comentada esta línea.
          // OJO: Hay que tener en cuenta que este buildwhen acá básicamente no nos va a servir ya que al estar definiendo el counterState a nivel del build y llamar
          //      el whatch esto causa que cada vez se cree una nueva instancia del state por lo tanto no nos sirve dicha condición, pero si comentamos las 2 líneas
          //      donde lo usamos vamos a ver que el print en la consola se muestra una solva vez cuando se resetea y no vuelve a mostrarse

          /*
          buildWhen: (previous, current) => current.counter != previous.counter,
          */

          //NOTA: Entonces como mencionamos tenemos un problema que es que aunque no estemos cambiando los valores, estamos creando una nueva instancia del estado
          //      y esto hace que se dispare cada vez, por lo tanto mencinamos que para solucionar ese problema podíamos usar el buildWhen pero este se usa sobre
          //      todo cuando tenemos una condición específica.
          //      Adicionalmente habíamos mencionado que existía una forma para evitar colocar dichas condiciones o validaciones y evitar usar ese buildWhen, y el
          //      cual es usando un paquete llamado Equatable, y este resuelve un problema que es bien común cuando tenemos objetos, ya que por ejemplo si creamos
          //      la instancia de una clase y luego creamos otra instancia de la misma clase esta segunda instancia regresa falso porque cuando creamos la primera
          //      instancia esta se asigna en un espacio diferente al de la segunda aunque hagan referencia al mismo objeto incluso si su información es idéntica
          //      y este es el problema que se trata de solucionar cuando usamos el buildWhen para que cuando los estados sean iguales no se creen nuevas instancias
          //      y solo se cree cuando se emite un nuevo estado.
          //      Y es ahí donde aparece Equatable el cual soluciona ese problema, y para ello Equatable lo que hace es que nosotros extendemos la clase de Equatable
          //      (en este caso nuestro CounterState) y tenemos que implementar una lista de propiedades que son usadas para compararlo, es decir, por ejemplo si
          //      tenemos una clase persona con la propiedad nombre si el nombre de esa persona es igual al nombre de una segunda persona, entonces esos objetos son
          //      iguales.
          //      Adicionalmente el problema que mencinamos cuando teníamos el counterState con el watch() que tratamos de solucionar antes con el buildwhen y que dijimos
          //      que de todas formas se estaba creando la instacia nuevamente y por lo tanto no estabamos solucionando nada y mostranba de todas formas el print, entonces
          //      con Equatable esto también se va a solucionar y esto es super super genial.
          //      La documentación la podemos encontrar en: https://pub.dev/packages/equatable
          builder: (context, state) {
            print('Counter cambió');
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
            onPressed: () => increaseCounterBy(context, 3),
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
            heroTag: '2',
            child: const Text('+2'),
            onPressed: () => increaseCounterBy(context, 2),
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
            heroTag: '3',
            child: const Text('+1'),
            onPressed: () => increaseCounterBy(context),
          ),
        ],
      ),
    );
  }
}
