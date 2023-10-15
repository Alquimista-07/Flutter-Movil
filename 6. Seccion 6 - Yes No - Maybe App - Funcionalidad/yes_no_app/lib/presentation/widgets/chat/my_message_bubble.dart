import 'package:flutter/material.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class MyMessageBubble extends StatelessWidget {
  // NOTA: Creamos una propiedad para el message
  final Message message;

  // Constructor
  const MyMessageBubble({super.key, required this.message});

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              // NOTA: Cambiamos el texto harcodeado y obtenemos el texto directamente del entity message y que proviene desde el Provider creado en el widget padre llamado chat_screen
              message.text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        // NOTA: Agregamos una separación entre cada BoxDecoration y el cual es un widget que usamos anteriormente y se había explicado su funcionamiento
        const SizedBox(height: 5)
      ],
    );
  }
}
