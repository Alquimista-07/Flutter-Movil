// NOTA: Recordemos que lo que nosotros estamos buscando no es usar el modelo de MovieDBResponse, es decir, no estamos queriendo que nuestra aplicación
//       se base en ese modelo ya que puede cambiar y por lo tanto queremos que se base en nuestro modelo propio que es el que tenemos en el domain/entities
//       Movie y si son muy similares ya que esta basado en la respuesta de la API pero no son iguales.
//       Por lo tanto yo quiero basarlo en mi entidad no en la respuesta que viene de TheMovieDB ya que eso es muy volátil y también porque adicionalmente
//       quiero que mi aplicación no solo funcione con TheMovieDB sino que al día de mañana pueda usar por ejemplo IMDB o un JSON propio o backend propio,
//       es decir, quiero que funcione con cualquier otro tipo de fuente de datos.
//       Adicionalmente esto genera una capa de protección para nuestra aplicacióno frente a posibles cambios de la API de terceros o API Externa.
// NOTA: Ahora ¿cuál es el objetivo del Mapper? El Mapper va a tener como única misión leer diferentes modelos y crear mi entidad.

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDB moviedb) => Movie(
      adult: moviedb.adult,
      backdropPath: (moviedb.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/w500/${moviedb.backdropPath}'
          : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg',
      // NOTA: Como tenemos un entero lo trasnformamos a una lista de String y esto es porque cuando lo recorremos se convierte en un iterable de string
      genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: (moviedb.posterPath != '')
          ? 'https://image.tmdb.org/t/p/w500/${moviedb.posterPath}'
          : 'no-poster',
      releaseDate: moviedb.releaseDate,
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount);
}
