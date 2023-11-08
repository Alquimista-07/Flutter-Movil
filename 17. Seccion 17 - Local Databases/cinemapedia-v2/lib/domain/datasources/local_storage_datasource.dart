import 'package:cinemapedia/domain/entities/movie.dart';

abstract class LocalStorageDatasource {
  // NOTA: Esto lo podemos hacer mandado la pelicula, o simplemente un booleano y de hecho lo vamos a hacer de las dos formas
  Future<void> toggleFavorite(Movie movie);

  Future<bool> isMovieFavorite(int movieId);

  // NOTA: Este método me va a ayudar a hacer la paginación donde el limit es para irlos cargando de 10 en 10 y el offset es para
  //       hacer la paginación
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0});
}
