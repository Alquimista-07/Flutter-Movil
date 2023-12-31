// NOTA: Ahora ya dentro de este directorio ya vamos a hacer las implementaciines que definimos
//       en el domain.
//       Por lo tanto la idea de este moviedb_datasource es estar especializado, nacer y ser concebido
//       únicamente para trabajar y tener las interaciones con ThMovieDB, y si al día de mañana queremos
//       usar IMDB seria implementar imdb_datasource o si tenemos un JSON sería localmovies_datasource.
//       y así crear X cantidad de datasources

import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
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

    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    // NOTA: Ahora se que el movieDBResponse trae los resultado que es una lista de MovieMovieDB
    //       pero una cosa es que el tipo es incompatible ya que uno es de tipo MovieMovieDB y el
    //       le estamos diciendo que es una lita de Movie por lo tanto vamos a pasarlo por un map
    //       y el objetivo de ese map es crear la instancia de Movie y como sabemos que esa tarea
    //       la va a cumplir el mapper entonces usamos ese mapper
    final List<Movie> movies = movieDBResponse.results
        // NOTA: Ahora como ajustamos en el movie_mapper para que en caso de que la película no tenga un poster y
        //       nos de es un string no-poster en vez de una url válida con una imágen por defecto, como si lo
        //       hicimos con el backdropPath eso va a causar que la apllicación reviente cuando tratemos de renderizar
        //       la imágen en Flutter. Y esto lo hicimos para tener 2 posibles opciones o ejemplos de lo que podríamos
        //       hacer.
        //       Entonces para controlar ese error que se nos podría presentar podemos usar un método adicional llamado
        //       where el cual es como un filtro ya que si la condición es true lo deja pasar y de esta forma controlamos
        //       para que cuando la película no venga con su poster no la deje pasar y así nos evitamos que tener que
        //       implementar validaciones del lado de Flutter para renderizar películas sin poster.
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();

    return movies;
  }
}
