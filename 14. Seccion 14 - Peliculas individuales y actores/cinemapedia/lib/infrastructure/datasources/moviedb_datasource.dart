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
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
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

  // NOTA: Notemos que tenemos una parte de, código que se empieza a repetir para los demás métodos por lo tanto vamos a crear un
  //       método para evitar eso.
  // OJO:  Para fines ilustrativos el código del método que tenemos para obtener las películas que están actualmente en cines
  //       (getNowPlaying) no lo voy a cambiar por este nuevo método, y lo voy a mantener como referencia pero hay que tener claro
  //       que se podría hacer. Adicionalmente este método si lo voy a usar para los demás método de obtener populares, próximamente,
  //       etc.
  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDBResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();

    return movies;
  }

  // NOTA: Implementación para obtener las películas que están en cines
  @override
  Future<List<Movie>> getNowPlaying({num page = 1}) async {
    final response = await dio.get('/movie/now_playing',
        // NOTA: Mandamos la pagina
        queryParameters: {'page': page});

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

  // NOTA: Obtener películas populares
  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response =
        await dio.get('/movie/popular', queryParameters: {'page': page});

    return _jsonToMovies(response.data);
  }

  //* Tarea: Próximamente
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response =
        await dio.get('/movie/upcoming', queryParameters: {'page': page});

    return _jsonToMovies(response.data);
  }

  //* Tarea: Mejor calificadas
  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response =
        await dio.get('/movie/top_rated', queryParameters: {'page': page});

    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');

    // NOTA: Validamos y agregamos la excepción en caso de que no regrese una películas, es decir, que no exista ese id
    if (response.statusCode != 200)
      throw Exception('Movie with id: $id not found');

    // NOTA: Hacemos el mapeo para obtener el objeto
    final movieDB = MovieDetails.fromJson(response.data);

    // NOTA: Ahora ocupamos un nuevo mapper que permita regresar la movie

    return movie;
  }
}
