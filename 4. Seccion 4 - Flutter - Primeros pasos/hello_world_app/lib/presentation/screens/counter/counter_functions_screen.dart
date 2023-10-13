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
        // NOTA: La propiedad mainAxisAlignment recordemos que es una propiedad de widget Column para cambiarle la ubicación en la pantalla, adicionalmente recordemos
        //       que este widget es un widget que recibe multiples hijos.
        //       Adicionalmente una nota importante es que si una propiedad nos sale en desuso o deprecated en la misma documentación que se nos da cuando dejamos el
        //       cursor sobre la propiedad o widget ahí nos va a sugerir cual reemplazo la que esta deprecated y por lo tanto la que deberíamos usar.
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // NOTA: Anteriormente teníamos 3 widget FloatingActionButton que casi eran lo mismo y los estabamos repitiendo y al repetirlos no estamos siguiente el concepto DRY (Don't Repeat Yourself)
            //       o no te repitas a ti mismo ya que estamos repitiendo código, entonces cuando empezamos a ver esto fácilmente podemos crear un widget personalizado que va a ser el cascaron y al cual
            //       le vamos a pasar propiedades y funcionalidades a través de parámetro y simplemente cada vez que lo necesitemos llamamos ese widget personalizado y le pasamos sus correspondientes
            //       valores y de esta forma acotamos o disminuimos las líneas de código haciendolo más legible.
            //
            //       Ahora existe una forma de EXTREAER el widget este caso podemos pararnos sobre el FloatingAtionButton presionar Ctrl + . y ahí nos va a dar la opción de Extract Widget peerrro esto siempre
            //       no va a servir ya que el widget en este caso tiene una dependencia con el clickCounter, el setState y no nos lo va a dejar extraer. Entonces lo que tenemos que hacer es quitar ese código de
            //       la función OnPressed y luego si aplicar la extracción como se mencionó anteriormente. Y luego nos pide que asignemos el nuevo nombre del widget
            CustomButton(
              icon: Icons.refresh_outlined,
              // NOTA: La propiedad shape nos permite redondear el botón y la mando por parámetro. Esto no estaba en el curso yo lo realice para aplicar lo aprendido
              shape: const StadiumBorder(),
              onPressed: () {
                setState(() {
                  clickCounter = 0;
                });
              },
            ),
            // NOTA: Hay muchas maneras de agregar separaciones en Flutter entre widgets, pero Uno de los widgets más comunes es el SizedBox el cual es como crear un contenedor
            //       o una caja con contenido específico con las dimiensiones que qeramos o necesitemos. Y esto es maravilloso de Flutter ya que gracias al HotReload podemos ver
            //       los cambios en caliente y agilizar el desarrollo ya que no hay que compilar la aplicación para ver lo que estemos modificando.
            const SizedBox(height: 10),
            CustomButton(
                icon: Icons.plus_one,
                onPressed: () {
                  clickCounter++;
                  setState(() {});
                }),
            // NOTA: Hay muchas maneras de agregar separaciones en Flutter entre widgets, pero Uno de los widgets más comunes es el SizedBox el cual es como crear un contenedor
            //       o una caja con contenido específico con las dimiensiones que qeramos o necesitemos. Y esto es maravilloso de Flutter ya que gracias al HotReload podemos ver
            //       los cambios en caliente y agilizar el desarrollo ya que no hay que compilar la aplicación para ver lo que estemos modificando.
            const SizedBox(height: 10),
            CustomButton(
                icon: Icons.exposure_minus_1_outlined,
                onPressed: () {
                  setState(() {
                    // NOTA: Validamos para que cuando el clickcounter sea cero haga un return y no haga nada, con el fin de evitar que se muestren números negativos.
                    if (clickCounter == 0) return;
                    clickCounter--;
                  });
                })
          ],
        ));
  }
}

// NOTA: Nuevo widget personalizado y que extrajimos con Ctrl + . OJO hay que tener en cuenta las notas realizadas respecto a la extracción del widget.
//       Ahora si nos damos cuenta este es un StatelessWidget por lo tanto no necesito manejar el estado ya que simplemente necesito recibir el OnPressed
//       y el ícono
class CustomButton extends StatelessWidget {
  // NOTA: Recordemos que el Icon recibe algo de tipo IconData por lo tanto ese es el tipo que tenemos que mandar.
  final IconData icon;

  // NOTA: Ahora necesito recibir el onPressed pero y como hago para saber de que tipo es, bueno para ello podemos darnos cuenta que el floatingActionButton
  //       ya lo tiene entonces podemos dar Ctrl + click sobre el widget para ir directamente a ver como realizaron su construcción el equipo de Flutter y
  //       buscarlo allí, entonces al encontrarlo nos damos cuenta que es de tipo VoidCallback por lo tanto ese sería el que nos serviría para nuestro widget
  //       personalizado. Adicionalmente el VoidCallback es una función que no regresa nada y la manejan como opcional entonces nosotros también podemos manejarla
  //       de esa manera.
  final VoidCallback? onPressed;

  // NOTA: La propiedad para redondear el botón yo mismo la agregue ya que quiero que los botones se vean diferentes y esto no lo hacían en el video del curso.
  final ShapeBorder? shape;

// Constructor. NOTA: Inicializamos los campos en el constructor, adicionalmente también podemos dar Ctrl + . para genera de forma automática el código.
//                    Otra cosa es que a pesar de que el onPressed lo tengo opcional es necesario inicializarlo en el constructor. Y lo mismo pasa con
//                    la propiedad shape que yo mismo coloque y que no esta en el curso.
  const CustomButton(
      {super.key, required this.icon, this.onPressed, this.shape});

// NOTA: Adicionalmente podemos jugar con las propiedades para ver que es lo que hacen e ir descubriendo y aprendiendo de esa forma. agregando o quitando propiedades
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      // NOTA: La propiedad shape nos permite redondear el botón
      shape: shape,
      // NOTA: La propiedad enableFeedback nos da una vibración o sonido cuando demos click en el botón
      enableFeedback: true,
      // NOTA: Elevación del botón
      elevation: 8,
      //backgroundColor: Colors.blue,
      onPressed: onPressed,
      splashColor: Colors.amberAccent,
      // NOTA: Ahora mandamos el icono que estamos recibiendo por parámetro por nombre, recordemos que también lo podríamos mandar de forma posiciones con un this.icon directamente en el
      //       constructor antes de abrir { pero esto queda a criterio de cada quién y en lo personal prefiero mandarlos por nombre pero hay que tener en cuenta que en algún momento tendremos
      //       que oblibar a que sea posicional al menos un argumento de la fucnión y como hemos visto en algunos de los widget que manejan los 2 tipos de parámetros.
      child: Icon(icon),
    );
  }
}
