import 'package:flutter/material.dart';

class MessageFieldBox extends StatelessWidget {
  const MessageFieldBox({super.key});

  @override
  Widget build(BuildContext context) {
    // NOTA: Propiedad para colocar el color y los bordes redondeadas en el input
    final outlineInputBorder = UnderlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(25));

    // NOTA: Estulos del input
    final inputDecoration = InputDecoration(
        // NOTA: Borde
        enabledBorder: outlineInputBorder,
        // Borde cuando se tiene foco en el input
        focusedBorder: outlineInputBorder,
        // NOTA: Para que se marque como sombreado
        filled: true,
        // NOTA: Colocamos el ícono pero esta vez usamos un IconButton para que no solo sea un icono sino también un botón para enviar como veríamos en un chat de otra aplicación.
        suffixIcon: IconButton(
          icon: const Icon(Icons.send_outlined),
          // NOTA: Acción al presionar el botón
          onPressed: () {
            print('Valor de la caja de texto');
          },
        ));

    return TextFormField(
      decoration: inputDecoration,
      // NOTA: Hay varias formas de mandar lo que se escribe en el input una es usando el onFieldSubmitted, otra el onChanged
      onFieldSubmitted: (value) {
        print('Submit value $value');
      },
      onChanged: (value) {
        print('Changed: $value');
      },
    );
  }
}
