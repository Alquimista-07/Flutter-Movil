// NOTA: La documentación oficial sobre este tipo de widget la podemos en contrar en la siguiente dirección url:
//       https://api.flutter.dev/flutter/widgets/AnimatedContainer-class.html
import 'package:flutter/material.dart';

// NOTA: Importamos el paquete de Dart para generar valores aleatorios, y notemos que usamos el show solo para importar esa clase en específico
//       y no todo el paquete.
import 'dart:math' show Random;

// NOTA: En este caso vamos a transformar el StatelessWidget en un StatefulWidget ya que requerimos actualizar el estado de la aplicación
//       y esto fácilmente podriamos hacerlo mediante un gestor de estado como el Provider pero como es algo relativamente sencillo lo vamos
//       a hacer de la forma nativa que es usando el StatefulWidget
class AnimatedScreen extends StatefulWidget {
  static const name = 'animated_screen';

  const AnimatedScreen({super.key});

  @override
  State<AnimatedScreen> createState() => _AnimatedScreenState();
}

class _AnimatedScreenState extends State<AnimatedScreen> {
  // NOTA: Propiedades que vamos a animar
  double width = 50;
  double height = 50;
  Color color = Colors.indigo;
  double borderRadius = 10.0;

  void changeShape() {
    final random = Random();

    // NOTA: Actualizamos de forma aleatoria los valores de las propiedades
    // NOTA: A la propiedad width le decimos que el valor máximo es 300
    //       y como no puede ser cero le sumamos 120 para que ese sea el
    //       valor inicial
    width = random.nextInt(300) + 120;

    // NOTA: Hacemos lo mismo o casi lo mismo con las demás propieades
    height = random.nextInt(300) + 120;
    borderRadius = random.nextInt(100) + 20;

    // NOTA: Ahora para el color hacemos lo siguiente para asignarlo en RGB y recordemos que el RBG va desde 0 a 255
    //       y el cuarto parmáetro de la función es el opacity
    color = Color.fromRGBO(
      random.nextInt(255), // Red
      random.nextInt(255), // Green
      random.nextInt(255), // Blue
      1, // Opacity
    );

    // NOTA: Actualizamos el estado
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Container'),
      ),
      body: Center(
        // NOTA: Usamos el widget AnimatedContainer y para el cual todas sus propiedades de pueden animar, como por ejemplo, el tamaño y el color
        child: AnimatedContainer(
          // NOTA: La propiedad duration es obligatoria y básicamente especifica el tiempo de la transación de la animación
          duration: const Duration(milliseconds: 400),
          // NOTA: Otra propiedad que podemos pasar es el curve, y la cual especifica el tipo de animación que queremos usar, por ejemplo que rebore
          //       al inicio o a la salida, entre otras
          curve: Curves.elasticInOut,
          width: width < 0 ? 0 : width,
          height: height < 0 ? 0 : height,
          decoration: BoxDecoration(
            color: color,
            borderRadius:
                BorderRadius.circular(borderRadius < 0 ? 0 : borderRadius),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // NOTA: Llamamos la función que genera valores aleatorios y actualiza el estado
        //       y notemos que lo podemos hacer de forma directa gracias a que la función
        //       no recibe argumentos, es decir, la candad de argumentos es la misma a los
        //       que tengo que enviar
        onPressed: changeShape,
        child: const Icon(Icons.play_arrow_rounded),
      ),
    );
  }
}
