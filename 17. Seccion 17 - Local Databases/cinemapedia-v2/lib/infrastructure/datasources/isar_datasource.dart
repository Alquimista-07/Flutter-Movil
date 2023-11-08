import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasource extends LocalStorageDatasource {
  // NOTA: Para empezar a usar Isar es necesario crear la instancia y pasarle los esquemas de la colección.
  //       Adicionalmente le especificamos el directorio o path donde almacenamos los datos y el cual es obligatorio.
  //       Por lo tanto para el path es necesario instalar el paquete path_provider y el cual lo encontramos en:
  //
  //       - https://pub.dev/packages/path_provider
  //

  late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    // NOTA: Como ahora es obligatorio el directorio o path y para el cual intalamos el paquete path_provider
    //       lo siguiente que vamos a hacer referencia a ese path
    final dir = await getApplicationDocumentsDirectory();

    // NOTA: Si no tenemos la instancia la creamos
    if (Isar.instanceNames.isEmpty) {
      // NOTA: El método open() recibe los schemas son los que creamos cuando ejecutamos el build de Isar para que autogenerara el archivo movies.g.dart a
      //       partir de el entity movie, dicha propiedad schemas es obligatoria. La siguiente propiedad que es obligatoria es el directory.
      //       Otra propiedad que le podemos indcar de forma opcional es el inspector el cual por defecto es true y este me va a permitir a mí tener un servicio
      //       y que Isar automáticamente va a levantar para yo poder ver como esta la base de datos, como mencionamos ya viene por defecto pero no esta de más
      //       indicarlo
      return await Isar.open(
        [MovieSchema],
        directory: dir.path,
        inspector: true,
      );
    }

    // NOTA: En caso de que ya tenga la intancia regreso esa intancia y la usamos
    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int movieId) {
    // TODO: implement isMovieFavorite
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    // TODO: implement loadMovies
    throw UnimplementedError();
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    // TODO: implement toggleFavorite
    throw UnimplementedError();
  }
}
