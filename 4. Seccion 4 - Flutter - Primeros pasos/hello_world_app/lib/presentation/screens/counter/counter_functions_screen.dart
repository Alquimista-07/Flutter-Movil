// NOTA: Básicamente este archivo contiene casi el mismo código que el CounterScreen o mejor dicho el código base que se tomo fue de allí
//       y se le realizaron algunas modificaciones para la explicación de la siguiente clase sobre el AppBar y las acciones. Por lo tanto
//       al ser una base del CounterScreen toda la documentación y notas que se tomaron cuando se creo aplica también para este archivo,
//       con la diferencia de que este archivo tiene algunas cositas y notas adicionales.
import 'package:flutter/material.dart';

class CounterFunctionsScreen extends StatefulWidget {
  const CounterFunctionsScreen({super.key});

  @override
  State<CounterFunctionsScreen> createState() => _CounterFunctionsScreenState();
}

class _CounterFunctionsScreenState extends State<CounterFunctionsScreen> {
  int clickCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Counter Functions'),
          // NOTA: Hay varias cosas interesantes que podemos hacer en el AppBar, como agregar ciertas propiedades muy útiles.
          //
          //       Por ejemplo podemos agregar el leading el cual requiere un icono que es un widget, y también requiere el onPressed, adicionalmente tenemos que
          //       acostumbrarnos a dejar el cursor sobre los métodos y propiedades para obtener la ayuda del editor y esto nos ayuda bastante cuando estamos
          //       iniciando ya que nos indica que es requerido, y de que tipo se tienen que mandar las propiedades.
          //       Adicionalmente este leading va a colocar el wiget en el AppBar del lado superior izquierdo
          /*
        leading: IconButton(
            // NOTA: EL Icon es un widget destinado solo para mostrar íconos, es decir, es un widget especial solo para mostrar íconos y por lo tnato se le manda como
            //       parámetro la data del icono que queremos mostar
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {}),
        */
          // NOTA: A part del leading también tenemos otra propiedad que es el actions, que va a colocar el widget en el AppBar del lado superior derecho, es decir, lo
          //       opuesto al leading. Adicionalmente el actions si nos fijamos es una lista de tipo widgets a diferencia del leading que solo pedía uno.
          actions: [
            IconButton(
                icon: const Icon(Icons.refresh_rounded),
                onPressed: () {
                  // Acá vamos a llamar el setState para inicializar a cero el clickCounter
                  setState(() {
                    clickCounter = 0;
                  });
                }),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$clickCounter',
                style:
                    const TextStyle(fontSize: 160, fontWeight: FontWeight.w100),
              ),
              Text(
                'Click${clickCounter == 1 ? '' : 's'}', // Otra forma de solucionarlo usando un ternario y si nos damos cuenta acá cambiamos una sola letra y sería una alternativa a la decisión que teniamos anterioremente
                style: const TextStyle(fontSize: 25),
              )
            ],
          ),
        ),
        floatingActionButton: Column(
          // NOTA: La propiedad mainAxisAlignment recordemos que es una propiedad de widget Column para cambiarle la ubicación en la pantalla, adicionalmente recordemos
          //       que este widget es un widget que recibe multiples hijos.
          //       Adicionalmente una nota importante es que si una propiedad nos sale en desuso o deprecated en la misma documentación que se nos da cuando dejamos el
          //       cursor sobre la propiedad o widget ahí nos va a sugerir cual reemplazo la que esta deprecated y por lo tanto la que deberíamos usar.
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              // La propiedad shape nos permite redondear el botón
              shape: const StadiumBorder(),
              onPressed: () {
                setState(() {
                  clickCounter = 0;
                });
              },
              child: const Icon(Icons.refresh_outlined),
            ),
            // NOTA: Hay muchas maneras de agregar separaciones en Flutter entre widgets, pero Uno de los widgets más comunes es el SizedBox el cual es como crear un contenedor
            //       o una caja con contenido específico con las dimiensiones que qeramos o necesitemos. Y esto es maravilloso de Flutter ya que gracias al HotReload podemos ver
            //       los cambios en caliente y agilizar el desarrollo ya que no hay que compilar la aplicación para ver lo que estemos modificando.
            const SizedBox(height: 10),
            FloatingActionButton(
              // La propiedad shape nos permite redondear el botón
              shape: const StadiumBorder(),
              onPressed: () {
                clickCounter++;
                setState(() {});
              },
              child: const Icon(Icons.plus_one),
            ),
            // NOTA: Hay muchas maneras de agregar separaciones en Flutter entre widgets, pero Uno de los widgets más comunes es el SizedBox el cual es como crear un contenedor
            //       o una caja con contenido específico con las dimiensiones que qeramos o necesitemos. Y esto es maravilloso de Flutter ya que gracias al HotReload podemos ver
            //       los cambios en caliente y agilizar el desarrollo ya que no hay que compilar la aplicación para ver lo que estemos modificando.
            const SizedBox(height: 10),
            FloatingActionButton(
              // La propiedad shape nos permite redondear el botón
              shape: const StadiumBorder(),
              onPressed: () {
                setState(() {
                  clickCounter--;
                });
              },
              child: const Icon(Icons.exposure_minus_1_outlined),
            )
          ],
        ));
  }
}
