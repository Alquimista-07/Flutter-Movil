// NOTA: Como este va a ser un provider que yo no lo voy a cambiar, es decir, una vez lo creo la primera vez ya no
//       va a ser modificado nunca más en su existencia, entonces puede ser un provider de únicamente lectura.
//       En este caso vamos a usar nuevamente Riverpod como nuestro gestor de estado por lo tanto instalamos el
//       paquete flutter_riverpod
// NOTA: Todo el objetivo de esta clase va a ser que nosotros proporcionemos nuestro MoriveRepositoryImpl de forma
//       global para que en cualquier otro provider yo tenga acceso a esa información

import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// NOTA: Este repositorio es inmutable.
//       Provider de solo lectura que provee el repositorio movie
final movieRepositoryProvider = Provider((ref) {
  // NOTA: Este nos va a pedir un datasource, es decir, el origen de datos para que funcione el movieRepositoryProvider
  //       y este es el corazón de todo lo que hemos estado haciendo.
  //       Ahora si al día de mañana ya no usamos TheMovieDB sino IMDB entonces simplemente mandariamos como parametro
  //       un IMDBDatasource por ejemplo y ya con esto tendriamos la implementación funcional de otro proveedor de información.
  return MovieRepositoryImpl(MoviedbDatasource());
});
