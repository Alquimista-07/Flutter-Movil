// NOTA: La documentación oficial sobre este tipo de widget la podemos en contrar en la siguiente dirección url:
//       https://api.flutter.dev/flutter/widgets/AnimatedContainer-class.html
import 'package:flutter/material.dart';

class AnimatedScreen extends StatelessWidget {
  static const name = 'animated_screen';

  const AnimatedScreen({super.key});

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
          curve: Curves.easeOutCubic,
          width: 300,
          height: 230,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(20)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.play_arrow_rounded),
      ),
    );
  }
}
