// NOTA: Esto no hace parte de la presentación por lo tanto no vamos a colocar widget ni nada visual en los archivos de este
//       directorio sino que va a ser código netamente de Dart. Ya que en la sección anterior dejamos lita toda la GUI de la
//       aplicación y acá en esta sección nos vamos a centrar en la lógica y funcionalidad.

// Enumeración para saber quien envía el mensaje, y recordemos que las enumerciones no cierran con ;
enum FromWho { me, hers }

// NOTA: Esta clase es para definir como va a lucir nuestros mensajes, luego si el día de mañana queremos agregar la hora, fecha en que se
//       mando, y también si fue leido o no lo podemos agregar aquí.
class Message {
  // Atributos
  final String text;
  final String? imageUrl; // Opcional
  final FromWho fromWho;

  // Constructor: EL tipo de constructor es con nombre
  Message({required this.text, this.imageUrl, required this.fromWho});
}
