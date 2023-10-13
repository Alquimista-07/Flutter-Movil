import 'package:flutter/material.dart';

// NOTA: Algo que acostumbro hacer es que cuando el nombre de la clase o widget tiene la palabra Screen
//       eso quiere decir que retorna un Scaffold
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // NOTA: Usamos una propiedad llamada leading y que anteriormente usamos en la primer app que desarrollamos, el cual nos permite colocar otro widget
        //       en este caso vamos a usar el widget circleAvatar que como su nombre lo indica es parecido a los avatares circulares de un perfil de usuario
        //       y lo envolvemos en un padding, recordemos que podemos ayudarnos con Ctrl + . para crear de forma automática el código y agilizar el desarrollo.
        leading: const Padding(
          padding: EdgeInsets.all(
              4.0), // Podemos modificar los parámetros del EdgeInsest para cambiar el tamaño del padding
          child: CircleAvatar(
            // NOTA: Este backgroundImage permite mostrar una imagen, el cual recibe algo de tipo ImageProvider o proveedor de imágenes, hay varias, por ejemplo imágenes desde la web
            //       o imágenes que están dentro de los assets pero poco a poco los vamos a ir viendo, de momento vamos a pasar una desde la web y para la cual usamos el NetworkImage
            backgroundImage: NetworkImage(
                'https://cdn3.emoji.gg/emojis/2210-kurumihehe.png'),
          ),
        ),
        title: const Text('Mi Amor ♥'),
        // NOTA: Podemos usar la propiedad centerTitle para centrar o alinear a la izquierda el título del appBar
        //       dependiendo si esta en true o false
        centerTitle: false,
      ),
    );
  }
}
