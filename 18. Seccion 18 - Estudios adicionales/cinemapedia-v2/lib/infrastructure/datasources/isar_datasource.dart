import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/entities.dart';
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
  Future<bool> isMovieFavorite(int movieId) async {
    // Esperamos que la base de datos este lista
    final isar = await db;

    // NOTA: OJO acá lo definimos como opcional ya que puede que la película este en favoritos como puede que no.
    //       Entonces vamos a decirle a isar que quiero que haga un filtro en mi esquema de movies. En este caso
    //       usamos un método autogenerado en nuestro esquema y que nos va a servir par comporara los ids. Dichos
    //       métodos autogenerados va a iniciar con el nombre de alguna propiedad de nuestra entity seguido de lo
    //       que hace y esto es precisamente para que sea fácil para nostros poder usarlos, adicionalmente si
    //       cambiaramos algo en nuestra entity tendríamos que generar nuevamente el Schema.
    final Movie? isFavoriteMovie =
        await isar.movies.filter().idEqualTo(movieId).findFirst();

    // Si es diferente de null regresa true en caso contrario false
    return isFavoriteMovie != null;
  }

  // NOTA: Para el paginado hacemos la condicion donde el offset sea igual al offset recibido y el limite sea igual al limite recibido
  //       nos va a traer todo, por lo tanto cada vez que actualicemos el offset va a hacer referencia a este por ejemplo en la primera
  //       trae del 1 al 10, la siguiente del 11 al 20 y así sucesivamente.
  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    final isar = await db;

    return isar.movies.where().offset(offset).limit(limit).findAll();
  }

  // NOTA: Para el tema del toggle es un poco más elavorado ya que acá ocupamos aplicar o realizar una transacción para que se escriba, actualice
  //       elimine o lea en la base de datos, es decir, hacer interaciones con la base de datos. Adicionalmente si se quiere hacer muchas interaciones
  //       a la vez esto se puede hacer dentro de una misma transacción. Para más información tenemos a disposición la documentación de Isar.
  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;

    // NOTA: Recordemos que es un toogle por lo tanto si esta en la base de datos la borramos y si no esta la insertamos.
    final favoriteMovie =
        await isar.movies.filter().idEqualTo(movie.id).findFirst();

    if (favoriteMovie != null) {
      // Borrar
      // NOTA: Este es similar al de insertar y le pasamos el isarId y usamos es el isarId porque esta indexado y sabemos cual es por lo tanto
      //       como ya sabemos que lo tenemos le indicamos el ! para que no marque error.
      //       Además en este punto cuando obtenemos el favoriteMovie ya hemos hecho la busqueda por lo tanto sabemos que lo tenemos.
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarId!));
      return;
    }

    // Caso contrario insertar.
    // NOTA: Acá tenemos el método writeTxn que es transacción normal y el writeTxnSync que es síncrono. Entonces en este caso usamo el sync
    //       y le indicamos la colección donde lo queremos insertar y le pasamos el método put
    isar.writeTxnSync(() => isar.movies.putSync(movie));
  }
}
