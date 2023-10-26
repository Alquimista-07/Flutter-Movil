// NOTA: Ahora ya dentro de este directorio ya vamos a hacer las implementaciines que definimos
//       en el domain.
//       Por lo tanto la idea de este moviedb_datasource es estar especializado, nacer y ser concebido
//       únicamente para trabajar y tener las interaciones con ThMovieDB, y si al día de mañana queremos
//       usar IMDB seria implementar imdb_datasource o si tenemos un JSON sería localmovies_datasource.
//       y así crear X cantidad de datasources

import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasource {
  // NOTA: Ahora como voy a ocupar hacer peticiones HTTP vamos a usar un paquete que anteriormente usamos
  //       llamado Dio, por lo tanto lo instalamos. Otra cosa es que Dio es similar a Axios que he usado
  //       en algunas ocuasiones en la web con React

  // NOTA: Creamos la instancia de Dio y a la cual le podemos pasar ciertas configuraciones por parámetro.
  //       Como por ejemplo el BaseOptions que recibe un baseUrl la cual básicamente le dice que todas las
  //       peticiones ban a pasar por esa base url pre-cargada.
  //       Adicionalmente la API de TheMovieDB necesita el api key y el idioma o language que como vimos se
  //       para como parámetros del query, por lo tanto los mandamos
  final dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
    'api_key': Environment.theMovieDbKey,
    'language': 'es-MX',
  }));

  // NOTA: Implementación para obtener las películas que están en cines
  @override
  Future<List<Movie>> getNowPlaying({num page = 1}) async {
    final response = await dio.get('/movie/now_playing');

    final List<Movie> movies = [];

    return movies;
  }
}
