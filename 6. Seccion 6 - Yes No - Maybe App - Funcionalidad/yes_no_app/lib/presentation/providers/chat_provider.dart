// NOTA: Un gestor de estados básicamente nos permite hacer la comunicación entre la capa de lógica y la de presentación con el fin de poder intercambiar información,
//       inicialmente en el curso vamos a usar el Provider y lo crearemos en un directorio aparte ya que como se mencionó es como una especie de intermediario.
//       Ahora hay muchos gestores de estado y a lo largo del curso vamos a aprender a usar varios, ahora en la hoja de rutas tenemos unos gestores de estado con su
//       respectiva documentación, cuales son recomendados directamente por el equipo de Flutter y otras recomendaciones dadas por Fernando.
//       Una cosa adicional es que la carpeta que va a contenerlo la llamaremos providers precisamente porque vamos a usar el gestor de estado Provider, pero si
//       estuvieramos trabajando con Block el directorio lo llamaríamos blocks o si estuvieramos con Qubites pues se podría llamar qubites y así sucesivamente,
//       Adicionalmente si tuvieramos varios providers para gestionar diferentes estados de nuestra aplicación también dentro de providers podríamos crear subdirectorios
//       para ordenar.
//       Otra cosa que hay que mencionar es que Provider es uno de los gestores de estado Flutter Favorite

import 'package:flutter/widgets.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  // NOTA: Provider sigue muchas cosas que ya vienen propiamente en fluter y si tiene su par de dependencias
  //       pero es algo muy útil de que nosotros ya no ocupemos hacer ningún tipo de instalación adicional,
  //       aunque si vamos a tener que instalar el gestor Provider como tal pero podemos trabajar siguiendo
  //       la misma filosofía de otros widgets que heredan modelos o que trabajan de esta manera.
  // NOTA: Ahora en cuanto al ChageNotifier en pocas palabras lo que dice es que puede notificar osea este
  //       ChatProvider puede notificar cuando hay cambios eso es básicamente todo, y cuando notifica cambios
  //       vamos a poder redibujar ciertas cosas.

  List<Message> messages = [
    Message(text: 'Hola amor!', fromWho: FromWho.me),
    Message(text: 'Ya regresaste del trabajo?', fromWho: FromWho.me)
  ];

  //NOTA: Vamos a regregar un Future vacío el cual es un método que va a recibir el mensaje y se va a ejecutar
  //      cuando se envía un mensaje
  Future<void> sendMessage(String text) async {
    // TODO: Implementar método
  }
}
