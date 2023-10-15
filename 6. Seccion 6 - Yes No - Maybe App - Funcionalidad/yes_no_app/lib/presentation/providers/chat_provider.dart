// NOTA: Un gestor de estados básicamente nos permite hacer la comunicación entre la capa de lógica y la de presentación con el fin de poder intercambiar información,
//       inicialmente en el curso vamos a usar el Provider y lo crearemos en un directorio aparte ya que como se mencionó es como una especie de intermediario.
//       Ahora hay muchos gestores de estado y a lo largo del curso vamos a aprender a usar varios, ahora en la hoja de rutas tenemos unos gestores de estado con su
//       respectiva documentación, cuales son recomendados directamente por el equipo de Flutter y otras recomendaciones dadas por Fernando.
//       Una cosa adicional es que la carpeta que va a contenerlo la llamaremos providers precisamente porque vamos a usar el gestor de estado Provider, pero si
//       estuvieramos trabajando con Block el directorio lo llamaríamos blocks o si estuvieramos con Qubites pues se podría llamar qubites y así sucesivamente,
//       Adicionalmente si tuvieramos varios providers para gestionar diferentes estados de nuestra aplicación también dentro de providers podríamos crear subdirectorios
//       para ordenar.
//       Otra cosa que hay que mencionar es que Provider es uno de los gestores de estado Flutter Favorite

// --------------------------------------------------------
// NOTAS INSTALACIÓN GESTOR DE ESTADO - PROVIDER
// --------------------------------------------------------
// NOTA: Para realizar la instalación del gestor Provider necesitamos visitar pub.dev y buscarlo allí.
//       Pub.dev es el sitio donde tenemos disponibles los paquetes desarrollados por el equipo de Flutter y la comunidad, es decir, allí podemos encontrar muchas cosas tanto gestores, como widgets y demás. Adicionalmente una cosa super importante es fijarnos para que plataforma nos
//       va a servir ese paquete ya que siempre no va a estar disponible para todas las plataformas, en este caso como estamos desarrollado para Android y IOS nos fijamos que dichas plataformas estén soportadas.
//
//       Ahora directamente para realizar la instalación si nos dirigimos a la pestaña installing allí vamos a ver mostrar la forma de instalarlo directamente mediante Flutter que es una forma fácil de añadirlo y el cual nos agrega la dependencia. Entonces solo lo que tenemos que hacer
//       es en la consola dentro del proyecto ejecutar el comando indicado.
//
//       Otra forma de instalarlo sería irnos directamente al archivo pubscpec.yaml y en la parte de las dependencias pegar la línea con la dependenia y la cual luego de grabar el archivo se va a descargar de forma automática.
//
//       Y otra forma es mediante la instalación de la extensión llamada Pubscpec Assist que instalamos anteriormente y la cual también nos ayuda a realizar la instalación de dependenicas, para usarlo simplemente vamos a la paleta de comando con Ctrl + Shift + P luego escribimos pub assist
//       y luego colocamos en este caso provider y esto va a realizar la instalación y a ordenar.
//
//       Ahora Provider me va a permitir tener los ChangeNotifier de manera global o a un cierto nivel de nuestro contexto de la aplicación, es decir, podemos colcar la instancia para que este disponible solo este en un punto por ejemplo intermedio en el árbol de widget y por lo tanto solo los
//       hijos que se desprendan o que dependan del que contiene el provider van a poder acceder al provider y los que estén por encima o afuera no lo van a poder hacer o no van a poder acceder al provider y no saben de su existencia. Por ejemplo podemos tener providers solo a nivel de formularios o
//       a niveles de widgets propiamente, pero si queremos que el provider funcione en toda la aplicación debemos colocarlo a un nivel muy alto para que todos los todos su demás widgets hijos lo puedan ver.
//
//       Entonces para hacer eso nos dirigimos al main.dart y vamos a envolver el MaterialApp con un nuevo widget llamado MultiProvider pero hay varios widgets que provider que nos permiten proveer esa información, pero el MultiProvider es muy útil porque usualmente puede ser que tengamos más de un
//       proveedor de información o más de una clase provider (que en este caso tenemos una que creamos dentro de la carpeta providers y llamamos chat_provider) que necesite compartir información a lo largo del mismo, por ejemplo una de autenticación, el chat, el tema o un gestor de temas, es decir,
//       pueda ser que necesitemos muchos providers y el MultiProvider es genial para eso. Entonces al MultiProvider le pasamos una propiedad providers, que tiene la lista de los providers.

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
