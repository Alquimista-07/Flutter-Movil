import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

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
    // NOTA: Hacemos la referencia al provider, adicionalmente el widget lo mantenemos como StatelessWiget ya que este no va a mantener el estado como hicimos con el
    //       ejercicio de la anterior aplicación, ya que ahora tenemos un gestor propiamente implementado y que se va a encargar de dicha tarea en particular.
    //       Entonces ya con esto va a estar pendiente de los cambios que sucedan en esa instancia de la clase.
    //       Y notemos que esto es muy parecido a lo que realizamos en la clase MyMessageBubble cuando obteníamos el tema con el Theme.of() solo que acá estamos obteniendo
    //       es el provider
    final chatProvider = context.watch<ChatProvider>();

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
              // NOTA: Al igual que la caja de texto en el Formulario donde colocamos el mensaje el ListView también tiene una propiead controller y a través de la cual podemos controlar para que el scroll
              //       se vaya al final cada vez que enviamos un mensaje. Pero este ScrollController tiene que ser notificado cuando enviemos el mensaje por lo tanto lo obtenemos desde el Provider y de esa
              //       forma ya quedan enlazados
              controller: chatProvider.chatScrollController,
              // NOTA: SI no especificamos la cantidad de elementos a mostrar el itemBuilder va a mostrar infinitos elementos en pantalla
              // itemCount: 100,
              itemCount: chatProvider.messages.length,
              itemBuilder: (context, index) {
                // Usamos nuestro widget personalizado que muestra las burbujas de chat de mis mensajes o mensajes que yo envío
                /*
                return
                    // Ahora para alternar las burbujas del chat vamos a ser un poco ingeniosos y obtener la división sintética para saber cuando son pares e impares con el fin de poder alternarlos dependiendo si es uno u otro
                    (index % 2 == 0)
                        ? const HerMessageBubble()
                        : const MyMessageBubble();
                */

                // NOTA: Regresamos una instancia de mi message que es mi entidad
                final message = chatProvider.messages[index];

                // NOTA: Y ahora este message sabe si el mensaje es de ella o mío y mostralos y usamos el ternario
                //       similar a como lo teníamos anteriormeente.
                return (message.fromWho == FromWho.hers)
                    ? HerMessageBubble(message: message)
                    // NOTA: Mandamos el message obtenido con el Provider hacia el widget hijo
                    : MyMessageBubble(message: message);
              },
            )),
            // Caja de texto para escribir mensajes
            // NOTA: Mandamos el mensaje a través del onValue llamando el método que tenemos en el provider y que se encarga de insertarlo a la Lista
            MessageFieldBox(
              // NOTA: Una forma de mandar el valor es a través de la siguiente línea de código
              /*
              onValue: (value) => ChatProvider().sendMessage(value),
              */
              // NOTA: Pero recordemos que si tenemos un solo argumento y este es el mismo que se envía en la misma posición podemos hacer lo siguiente;
              onValue: chatProvider.sendMessage,
            )
          ],
        ),
      ),
    );
  }
}
