// NOTA: Acá no voy a tener las implementaciones ya que acá en datasources es como quiero
//       que sean los origenes de datos. Y por lo tanto el objetivo de esta clase es que
//       sea abstracta ya que no quiero crear instancias de ella.
//
//       Adicionalmente acá en el datasource voy a definir como lucen los origenes de datos
//       que pueden traer peliculas, puede ser de MovieDB, IMDB, mi API propia, un JSON de
//       donde sea.

import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MoviesDatasource {
  // Peliculas actualmente en cartelera
  Future<Movie> getNowPlaying({int page = 1});
}
