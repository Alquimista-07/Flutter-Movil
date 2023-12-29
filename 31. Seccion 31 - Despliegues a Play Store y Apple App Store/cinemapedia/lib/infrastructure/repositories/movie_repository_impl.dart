// NOTA: Esta implementación básicamente lo que va a hacer es llamar el datasource y el datasource
//       va a llamar los métodos
// NOTA: Ahora todo esto lo estamos haciendo para que yo fácilmente pueda cambiar los origenes de datos
//       pero cuando yo esto con mis providers de Riverpod, simplemente llamo esta implementación y esa
//       implementación ya va a tener el datasource y fácilmente ya puedo mandar a llamar tod el mecanismo
//       de funcionalidad.

import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/entities.dart';
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

  // NOTA: Obtener películas populares
  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }

  //* Tarea: Próximamente
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return datasource.getUpcoming(page: page);
  }

  //* Tarea: Mejor calificadas
  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page);
  }

  // NOTA: Obtener película por id
  @override
  Future<Movie> getMovieById(String id) {
    return datasource.getMovieById(id);
  }

  // Búsqueda de películas
  @override
  Future<List<Movie>> searchMovies(String query) {
    return datasource.searchMovies(query);
  }

  // Obtener películas similares
  @override
  Future<List<Movie>> getSimilarMovies(int movieId) {
    return datasource.getSimilarMovies(movieId);
  }

  // Obtener video trailer de YouTube para la película por id
  @override
  Future<List<Video>> getYoutubeVideosById(int movieId) {
    return datasource.getYoutubeVideosById(movieId);
  }
}
