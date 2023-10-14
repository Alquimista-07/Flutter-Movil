import 'package:flutter/material.dart';
import 'package:yes_no_app/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';

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
      body: _ChatView(),
    );
  }
}

// NOTA: Extraemos el widget column y lo volvemos un widget privado, por lo tanto al ser privado no es necesario agregarle un constructor por lo tanto lo quitamos.
//       Adicionalmente vamos a usar un Column porque necesitamos colocar varios widgets y como sabemos el Column recibe varios hijos. En este caso mandamos solo
//       dos widgets, uno va a ser el listview donde se muestran los mensajes enviados y otro que es la caja de texto donde escribimos y enviamos el mensaje. Otra
//       razon por la que usamos el Column es porque necesitamos colocar uno abajo de otro y lo podemos corroborar en la hoja de atajos de Flutter de la sección 1
class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // NOTA: El widget safeArea empuja los widget contenidos dentro a una área segura para que no interfiera con los controles del sistema y que estan ubicaso en la parte inferior,
    //       es decir, donde estan ubicados los botones de home, atrás y cerrar aplicaciones en Android, y lo mismo en iOS según corresponda
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            // NOTA: Ahora usamos el widget Expanded para que el widget que le pasamos se expanda a toda la pantalla que tiene disponible
            Expanded(
                // NOTA: AL expanded le pasamos el widget ListView, y este tiene varias formas de construirse, es decir tiene varias formas de construirse,
                //       tiene el ListView normal, el ListView.builder, el ListView.separated, etc.
                //
                //       Adicionalmente tenemos que tener en cuenta que cuando veamos la palabra builder en Flutter, eso nos quiere decir que es un tipo de función que Flutter en tiempo de ejecución va a ejecutar
                //       para construir ese widget y esto permite tener una lista de miles de elementos, pero solo los que van a estar a punto de entrar en pantalla, los que están en pantalla, y los que acaban de entrar
                //       son los que van a estar visibles y construidos, todos los demás no existen hasta que se creen bajo demanda. Adicionalmente este lo tenemos en la hoja de atajos de Flutter de la sección 1.
                //       El itemBuilder recibe una función y si damos Ctrl + espacio nos da la opción de crear 2 estilos de función una flech que regresa inmediatamente un widget y otra con cuerpo, y esta función recibe
                //       el build context que es el árbol de widgets y el indice que el list builder este utilizando en ese momento.
                child: ListView.builder(
              // NOTA: SI no especificamos la cantidad de elementos a mostrar el itemBuilder va a mostrar infinitos elementos en pantalla
              itemCount: 100,
              itemBuilder: (context, index) {
                // Usamos nuestro widget personalizado que muestra las burbujas de chat de mis mensajes o mensajes que yo envío
                return
                    // Ahora para alternar las burbujas del chat vamos a ser un poco ingeniosos y obtener la división sintética para saber cuando son pares e impares con el fin de poder alternarlos dependiendo si es uno u otro
                    (index % 2 == 0)
                        ? const HerMessageBubble()
                        : const MyMessageBubble();
              },
            )),
            Text('Mundo!!!...')
          ],
        ),
      ),
    );
  }
}
