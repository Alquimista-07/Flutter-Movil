import 'package:flutter/material.dart';
import 'package:hello_world_app/presentation/screens/counter/counter_screen.dart';

void main() {
  // NOTA: Entonces según lo mencionado anteriormente respecto al widget inicial este se va a ejecutar con un comando que se llama runApp.
  //       Si dejamos el cursor so bre runApp nos damos cuenta que recibe un widget app. Básicamente un widget es cualquier cosa que sea
  //       un stateless o un stateful widget. Entonces cuando veamos que algo recibe un widget, literalmente recibe cualquier cosa, es decir,
  //       textos, botones, listas cualquier cosa que sea un widget.
  //       Entonces para aclarar un stateless widget y un stateful widget en el pdf entregado por Fernando en la sección 1 esta la definición
  //       de ambos.
  runApp(
      // NOTA: Adicionalmente tenemos un warning que nos dice que agregemos la plabra const para mejorar el performance, pero y porque es esto
      //       básicamente es porque si nos damos cuenta nuestra app renderiza información estática, esto quiere decir que desde elmomento en que
      //       se construye la aplicación todo lo que tenemos no va a cambiar ya que no hay textos ni nada dinámico. Entonces al indicale que es
      //       una constante (const) le estamos diciendo que esto nunca va a cambiar
      const MyApp()); // Acá instanciamos nuestra clase MyApp (Que es nuestro primer statel3ss widget que vamos a usar)
}

// NOTA: Vamos a ver nuestro primer widget que es un Stateless widget
class MyApp extends StatelessWidget {
  // Constructor al cual le asignamos el key que el key no es más que la forma en la que se identificarlo específicamente por esa llave
  // Y tenemos que crearlo cuando lo pida. Adicionalmente como se había mencionado anterioremente podemos usar el Ctrl + . para agregar
  // automáticamente el código.
  const MyApp({super.key});

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
    //       Además dada la explicación de más arriba en el momento de instanciar la clase del porque colocamos el const entonces acá hacemos lo mismo y esto nos quita los
    //       warnings.
    return const MaterialApp(
        // NOTA: Entonces en este widget voy a poner el home y el home va a ser un texto que dice Hola Mundo. Y notemos que nuestro MaterialApp tiene un home
        //       que tiene otro widget Text que recibe el Hola Mundo. Y básicamente esta clase Text es la que vamos a utilizar para mostrar los textos en pantalla
        //       pero hay que tener en cuenta que existen otras formas pero esta es la más común.
        //       Adicionalmente el Text lo envolvemos en otro widget llamado Center, el Center se encarga de envolver su hijo en las dimensiones que tenga disponible el padre,
        //       en este caso toda la pantalla

        // home: Center(child: Text('Hola Mundo!!!...')),

        // NOTA: Dentro del MaterialApp hay una propiedad llamada debugShowCheckedModeBanner, la cual nos permite quitar el cartel que dice DEBUG en la parte superior derecha
        //       de la aplicación y que la verdad estorba, pero básicamente Flutter la coloca por defecto para indicar que la app esta en desarrollo pero pues nosotros ya sabemos
        //       que esta en desarrollo entonces la deshabilitamos con esa propiedad banner. Adicionalmente para ayudarnos podemos dar Ctrl + barra espaciadora y escribir parte de
        //       la palabra por ejemplo banner y nos va a mostrar las diferente opciones que concuerdan para seleccionar,
        debugShowCheckedModeBanner: false,

        // NOTA: Ahora para el siguiente ejercicio comentamos el hola mundo y lo cambiamos por un scaffold que es otro widget, este widget también lo tenemos explicado en la hoja de rutas
        //       y acostumbremonos a revisarla ya que es de mucha ayuda.
        //       El Scaffold da las bases de un diseño de material y nosotros podemos usarlo para definir pantallas, eso ayuda por ejemplo a establecer el fondo blanco o si estamos en una
        //        app con tema Dark lo va a usar y esto es nuestra base inicial.
        //
        //NOTA:  Adicionalmente luego lo que hicimos fue trasladar el Scaffold que inicialmente teníamos acá en el home a un archivo nuevo e independiente llamado counter_screen dentro el directorio presentation/screens
        //       esto debido a que como sabemos tenemos que tener una estructura definida para llevar un orden y adicionalnente esto hace que sea más mantenible ya que tenemos partes más pequeñas de código en diferentes
        //       archivos. Y simplemente para usarlo creamos la instancia de la clase donde tenemos el Scaffold y no olvidemos la imoortación.
        home: CounterScreen());
  }
}
