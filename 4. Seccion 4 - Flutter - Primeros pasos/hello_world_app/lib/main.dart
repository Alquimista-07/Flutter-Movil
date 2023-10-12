import 'package:flutter/material.dart';

void main() {
  // NOTA: Entonces según lo mencionado anteriormente respecto al widget inicial este se va a ejecutar con un comando que se llama runApp.
  //       Si dejamos el cursor so bre runApp nos damos cuenta que recibe un widget app. Básicamente un widget es cualquier cosa que sea
  //       un stateless o un stateful widget. Entonces cuando veamos que algo recibe un widget, literalmente recibe cualquier cosa, es decir,
  //       textos, botones, listas cualquier cosa que sea un widget.
  //       Entonces para aclarar un stateless widget y un stateful widget en el pdf entregado por Fernando en la sección 1 esta la definición
  //       de ambos.
  runApp(
      MyApp()); // Acá instanciamos nuestra clase MyApp (Que es nuestro primer statel3ss widget que vamos a usar)
}

// NOTA: Vamos a ver nuestro primer widget que es un Stateless widget
class MyApp extends StatelessWidget {
  // NOTA: Adicionalmente luego de crear la clase y extenderla nos da un error solicitando que creemos el método build. Y una forma rápida para
  //       crearlo es dar Ctrl + . y ahí nos va a dar la sugerencia de lo que podemos hacer, y para este caso le decimos que Create 1 missing
  //       override y esto nos va a crear el método automáticamente.
  //
  //       Si nos damos cuenta el método build retorna un widget y recibe como parámentro el BuildContext( El BuildContext también está explicado en la hoja de atajos )
  @override
  Widget build(BuildContext context) {
    // NOTA: Dentro de este método tengo que retornar un widget, y ese primer widget va aser un MaterialApp, y este MaterialApp es básicamente nuestra aplicación.
    //       Recordemos siempre colocar el cursor encima de los métodos y variables para obtener la ayuda del editor, el cual nos dice en este caso que tiene un montón de
    //       cosas y otas cosas respecto a la documentación del widget.
    return MaterialApp(
      // NOTA: Entonces en este widget voy a poner el home y el home va a ser un texto que dice Hola Mundo. Y notemos que nuestro MaterialApp tiene un home
      //       que tiene otro widget Text que recibe el Hola Mundo. Y básicamente esta clase Text es la que vamos a utilizar para mostrar los textos en pantalla
      //       pero hay que tener en cuenta que existen otras formas pero esta es la más común.
      //       Adicionalmente el Text lo envolvemos en otro widget llamado Center, el Center se encarga de envolver su hijo en las dimensiones que tenga disponible el padre,
      //       en este caso toda la pantalla
      home: Center(child: Text('Hola Mundo!!!...')),
    );
  }
}
