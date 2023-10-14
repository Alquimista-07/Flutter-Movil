import 'package:flutter/material.dart';

class MyMessageBubble extends StatelessWidget {
  // Constructor
  const MyMessageBubble({super.key});

  @override
  Widget build(BuildContext context) {
    // NOTA: Ahora pedimos que busque el tema del contexto y como nuestro contexto global le estamos asignando los colores
    //       en nuestra clase personalizada para esto va a cambiar los colores de forma automática cada vez que cambiemos
    //       el tema en la app.
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
              // NOTA: Asignamos el color tomado a partir de nuestro contexto global.
              color: colors.primary,
              // NOTA: Hacemos redondos el boxDecoration.
              borderRadius: BorderRadius.circular(20)),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Tempor excepteur exercitation',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        // NOTA: Agregamos una separación entre cada BoxDecoration y el cual es un widget que usamos anteriormente y se había explicado su funcionamiento
        const SizedBox(height: 10)
      ],
    );
  }
}
