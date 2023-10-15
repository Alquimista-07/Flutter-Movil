import 'package:flutter/material.dart';

class MessageFieldBox extends StatelessWidget {
  // NOTA: Ahora lo que yo quiero hacer es crearme una propiedad para que tenga un funcionamiento similar
  //       al onFieldSubmitted, es decir, poder emitir el valor que la caja de texto envia al submitir o
  //       o tocar el botón de enviar. Entonces si damos Ctrl + Click sobre el onFieldSubmitted vemos que es
  //       una propiedad de tipo ValueChanged que es la firma para callbacks que regresan un valor, recordemos
  //       de cuando teníamos el voidCallback que no regresaba nadas, entonces este es lo opuesto
  final ValueChanged<String> onValue;

  const MessageFieldBox({super.key, required this.onValue});

  @override
  Widget build(BuildContext context) {
    // NOTA: Este elemento TextEditingController como su nombre lo indica nos va a dar control sobre el input en el que lo voy a usar
    //       y es algo que vamos a ver más a detalle cuando manejemos formularios más complejos
    //       como un login entre otras cosas que veremos más adelante en el curso.
    final textComtroller = TextEditingController();

    // NOTA: Propiedad para mantener el foco cuando se envía el mensaje y que el teclado no se cierre
    final focusNode = FocusNode();

    // NOTA: Propiedad para colocar el color y los bordes redondeadas en el input
    final outlineInputBorder = UnderlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(25));

    // NOTA: Estulos del input
    final inputDecoration = InputDecoration(
        hintText: 'End your message with a "?"',
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
            // NOTA: Obtenemos el valor de la caja de texto al presionar el IconButton
            final textValue = textComtroller.value.text;
            // NOTA: Mandamos a llamar el onValue con el valor del textValue para enviar el mensage para que el Provider lo inserte a la lista
            onValue(textValue);
            // NOTA: Limpiamos la caja de texto
            textComtroller.clear();
          },
        ));

    return TextFormField(
      // NOTA: Propiedad para el comportamiento cuando hacemos click fuera del input
      onTapOutside: (event) {
        // NOTA: Entonces cuando haga click fuera del input perdemos el foco y cerramos el teclado
        focusNode.unfocus();
      },
      // NOTA: Asignamos la propiedad para mantener el foco cuando se hace submit y no cerar el teclado
      focusNode: focusNode,
      // NOTA: Agregamos el controlador
      controller: textComtroller,
      decoration: inputDecoration,
      // NOTA: Hay varias formas de mandar lo que se escribe en el input una es usando el onFieldSubmitted, otra el onChanged
      onFieldSubmitted: (value) {
        //print('Submit value $value');

        // NOTA: Mandamos a llamar el onValue con el valor del textValue para enviar el mensage para que el Provider lo inserte a la lista
        onValue(value);
        // NOTA: Limpiamos el valor del input cuando se envía
        textComtroller.clear();
        // NOTA: Luego de que se limpia siempre mantengo el foco y no se cierre el tecado
        focusNode.requestFocus();
      },
      // NOTA: Esta es otra forma de obtener el valor del input pero para este caso no lo vamos a ocupar
      /*
      onChanged: (value) {
        print('Changed: $value');
      },
      */
    );
  }
}
