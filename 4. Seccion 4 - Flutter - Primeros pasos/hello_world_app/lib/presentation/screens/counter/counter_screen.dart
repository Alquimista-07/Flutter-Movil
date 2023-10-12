// NOTA: El shortcut para importar rápido el paquete de material es: impm
import 'package:flutter/material.dart';

// EL shortcut para crear rápido el statless widget es: stless
// y esto ya nos crea la estructura inicial que tenemos que tener y que vamos a modificar
// Posteriormente para manejar el estado y cambiarlo cuando presionemos el botón ya no usamos el Statelesswidget sino un StatefulWidget
// entonces para cambiarlo nos ubicamos sobre el StatelessWidget y damos Ctrl + . y le decimos que los transofme a un StatefulWidget
class CounterScreen extends StatefulWidget {
  // Constructor
  const CounterScreen({super.key});

  // NOTA: Para lograr que al presionar el botón haga algo vamos a ocupar manejar manejar el concepto del estado global, o el estado de la aplicación o el estado
  //       de los widgets, es decir, son varios conceptos diferentes y entiendase como el estado de un widget todo el estado relacionado al widget en particular y
  //       sus hijos.
  //
  //       Por ejemplo si dentro del widget manejaramos una variable llamada clickCounter esto quiere decir que todos los widgets, toda la información, es decir,
  //       absolutamente todo lo que este dentro del widget CounterScreen técnicamente va a tener acceso al clickCounter. Pero OJO esto no es tan sencillo como pensamos
  //       ya que lo mencionado sería un estado a nivel de widget y sus hijos van a poder llegar de alguna manera al clickCounter no de una forma directa ya que tnedriamos
  //       que recibir propiedades, esperar cuando hagamos nuestro widgets personalizados que más adelante lo vamos a hacer pero técnicamente este clickCounter es el valor
  //       de mi estado.
  //
  //       Luego cuando hablamos de un estado global de la aplicación, es un estado que todos los widgets sin importar la posición en la que se encuentren en el árbol de widgets
  //       (BuildContext y que tenemos en la hoja de atajos y recordemos que el BuildContext sabe la posición específica del widget gracias al key), entonces podríamos colocar
  //       en ese árbol de widgets un estado en algún lugar y que todos los widgets puedan consultar ese estado y para lograr eso también tenemos unos paquetes especiales que también
  //       más adelante vamos a llegar a ellos que son gestores de estado (sobre los cuales también tenemos un resumen en la hoja de atajos)
  //
  //       Ahora SI para manejar el estado convertimos la clase o nuestro widget en StatefullWidget y en esta tenemos este nuevo método que se llama createStare. Cuando se crea en este caso el CounterScreen
  //       y es un StatefullWidget automáticamente va a mandar a llamar la creación del estado y esta creación del estado no es más que la invocación de otra clase en este caso llamada _CounterScreenState() y
  //       esta otra clase es la clase que nos creo automáticamente y que es la construcción de nuestro widget que teníamos hasta el momento solo que la clase _CounterScreenState() en lugar de extender
  //       de un StatelessWidget extiende de un State que es la clase y va a manejarle el CounterScreen, osea va a ser el estado del counter Screen.
  //
  //       Ahora esto puede parecer abrumador y se nos puede hacer complicado y pensar que en que momento vamos a aprender esto, pero la verdad es que solo
  //       hay dos tipos de widget los stateless y los statefull punto.
  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  // Ahora SI luego de toooooooooooooooooooooda la explicación dada anteriormente y luego de transformar nuestro widget en un Statefullwidget ahora si acá podemos manejar nuestar variable que mencionamos al inicio
  // con la cual vamos a manejar el estado y que llamamos en el caso del ejemplo clickCounter
  int clickCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Agregamos el appBar para poner el título en la aplicación
      appBar: AppBar(
        title: const Text('Counter Screen'),
      ),
      // NOTA: Hay muchos widgets que solo tienen un hijo pero hay algunos widgets que también reciben
      //       múltpiles hijos y los cuales podemos revisar algunos en la hoja de atahos de Flutter.
      //       Entonces quitamos el widget Text y ahora vamos a usar otro widget que recibe múltpiles hijos.
      //body: Center(child: Text('Counter Screen!!!...')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .center, // Esta propiedad MainAxisAlignment es similar a Flexbos Grid en web, es decir, sirve para ubicar el widget o widgets dentro de la pantalla.
          children: [
            Text(
              // Ya no mostramos un valor estático sino que vamos a mostrar nuestro clickCounter que tiene el estado y pasarlo como un String ya sea usando el método .toString()
              // o psandolo con la interpolación de String y que vimos en la sección de introducción a Dart
              //'10',
              '$clickCounter',
              style:
                  const TextStyle(fontSize: 160, fontWeight: FontWeight.w100),
            ),
            const Text(
              'Clicks',
              style: TextStyle(fontSize: 25),
            )
          ],
        ),
      ),
      // Colocamos el botón flotante, y esto recordando que en la hoja de ruta de Flutter vemos que el Scaffold es una interfaz en la cual podemos implementar botones
      // flotantes entre otras cosas. Entonces creamos un FloatinAction Button el cual necesita el método onPressed y a este le vamos a mandar una función
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // NOTA: Ahora si podemos actualizar el estado de nuestro widget y de nuestra variable clickCounter al presionar el botón
          //  clickCounter = clickCounter + 1; // Una forma de incrementar
          // clickCounter += 1; // Otra forma de incrementar
          clickCounter++; // Otra forma de incrementar.
          // NOTA: Adicionalmente nosotros tenemos que decirle a Flutter cuando queremos que se renderice nuevamente la pantalla o mejor dicho cuando se renderice nuevamente
          //       nuetro widget. Entonces cuando hago la modificación del estado yo necesito mandar a llamar una función especial de Flutter para que actualice la pantalla
          //       por decirlo así que vuelva a renderizar ese componente. Y la función es el setState, la cual podemos llamar así
          /*
          setState(() {
            clickCounter++;
          });
          */
          //       O también podemos llamrala así, pero hay que psarle el callback () {} si no nos da un error
          setState(() {});
          // NOTA: Un dato importante es que cuando nosotros volvemos a redibujar el widget, literalmente redibuha el widget en el que me encuentro, entonces si yo le digo acá el
          //       setState entonces va a empezar a redibujar todo este state, es decir todo lo que tenemos en el build, y literalmente va volver a crear un Scaffold, un Appbar,
          //       pero como el titulo del appBar es constante simplemente lo vuelve a tomar no lo vuelve a generar y así sucecivamente, pero no así del todo como funciona ya que
          //       FLutter es lo suficientemente eficiente para determinar que es lo afectado en los cambios y si no hay nada afectado no lo renderiza nuevamente, simplemente usa
          //       el estado anterior y Flutter es super super eficiente en ese aspecto y es de las tecnologías más rápidas que hay para desarrollo móvil y es casi bien cercano al.
          //       desarrollo nativo.
        },
        // Y el child del floatinActionButton recibe otro widget, cual quier widget es decir puede ser un texto, otor botón, lo que sea. En este caso es un Icon el cual es otro widget
        // que recibe el Icons.plus_one (conocido como IconData) que es el ícono que queremos mostrar
        child: const Icon(Icons.plus_one),
      ),
    );
  }
}
