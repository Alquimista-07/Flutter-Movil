// NOTA: Con esto esoy definiendo mis reglas de nogicio y la estructura de datos de la aplicación.
//       Y esto es lo que siempre vamos a usar y no lo que venga directamente de la API ya que eso
//       puede cambiar.
//-----------------------------------------------
// NOTAS IMPORTANTES BASE DE DATOS LOCAL
//-----------------------------------------------
// NOTA: En esta caso vamos a usar una base de datos local para almacenar los favoritos del usuario, pero fácilmente se podría hacer con peticiones HTTP, para guardarlas
//       en una base de datos accesible desde internet y manejarlo de esa forma, pero para efectos del curso vamos a hacerlo local ya que esto nos puede ser útil en un
//       futuro ya que hay varios casos en los cuales podríamos necesitar usar una base de datos local en caso de que no haya conexión a internet para luego sincronizarla
//       con una en internet cuando este este dispobile.
//       Ahora acá voy a dejar enlace de documentación de diferentes bases de datos locales usadas en dispositivos móviles y de las cuales algunas al ser indexadas también
//       sirven para la web siempre y cuando el navegador tenga dicho soporte.
//
// - https://pub.dev/packages/shared_preferences -> Paquete de Flutter Shared Preferences
// - https://firebase.google.com/docs/flutter/setup?platform=ios&hl=es-419 -> Firebase
// - https://docs.flutter.dev/cookbook/persistence/sqlite -> SQLite
// - https://docs.hivedb.dev/#/ -> Hive
// - https://isar.dev/es/ -> Isar Database
//
//        En este caso vamos a usar Isar Database la cual esta hecha para Flutter, es una base de datos No relacional, es muy poderosa e incluso los desarrolladores de Hive en su web
//        recomiendan usar Isar ya que soluciona muchos problemas y es muy sencilla de usar.
//        Por lo tanto nos dirigimos a la web de Isar y dar click en get Stated y ahí nos va a indicar los pasos a seguir, ya que ocupamos instalar algunas dependencias y hacer configuraciones
//        y agregar las correspondientes anotacioness
import 'package:isar/isar.dart';

// NOTA: Tenemos que agregar el part que es un archivo con el nombre del archivo y la clase de la entidad, el cual se va a generar
//       de forma automática, y nos va a marcar un error pero esto es normal, y el cual va a ser generado cuando ejecutemos alguno
//       de los dos siguientes comandos en la terminal, en este caso vamos a usar el de flutter pero el otro también sirve.
//
//       - dart run build_runner build
//       - flutter pub run build_runner build
//
//       Y ya con esto se resuelve el error que mencionamos anteriormente. Por lo tanto al ejecutar el comando lo que va a hacer es verificar
//       los archivos que estén anotados o decorados con el @collection y aparte que también tengan el part con el .g y ojo que el .g es
//       importante.
//       Otra cosa es que ese archivo .g se genera automáticamente y contiene muchas cosas como funciones, métodos y propiedades, que nos van a
//       ayudar a trabajar de forma sencilla, adicionalmente esto básicamente nos va a crear nuestro esquema de base de datos, y el esquema es una
//       representación de la entidad que tenemos para que podamos usar por ejemplo métodos como movie.getById el cual nos va a hacer la consulta
//       de forma sencilla basada en objetos por lo tanto tomeos esto como si fuera un ORM. Por lo tanto dicho archivo NO lo modificamos directamente.
part 'movie.g.dart';

@collection
class Movie {
  // NOTA: Tenemos que agregar el id que es un identificador único para la base de datos de Isar
  Id? isarId;

  final bool adult;
  final String backdropPath;
  final List<String> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Movie(
      {required this.adult,
      required this.backdropPath,
      required this.genreIds,
      required this.id,
      required this.originalLanguage,
      required this.originalTitle,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.releaseDate,
      required this.title,
      required this.video,
      required this.voteAverage,
      required this.voteCount});
}
