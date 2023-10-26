// NOTA: Esta implementación básicamente lo que va a hacer es llamar el datasource y el datasource
//       va a llamar los métodos
// NOTA: Ahora todo esto lo estamos haciendo para que yo fácilmente pueda cambiar los origenes de datos
//       pero cuando yo esto con mis providers de Riverpod, simplemente llamo esta implementación y esa
//       implementación ya va a tener el datasource y fácilmente ya puedo mandar a llamar tod el mecanismo
//       de funcionalidad.

import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  // NOTA: Acá lo que vamos a hacer en nuestra implementación es mandar a llamar el datasource para que llame
  //       el método.

  final MoviesDatasource datasource;

  MovieRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }
}
