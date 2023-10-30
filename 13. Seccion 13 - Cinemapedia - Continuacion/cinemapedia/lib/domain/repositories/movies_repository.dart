// NOTA: Notemos que esta clase es igual a la clase de datasource, pero la diferencia radica es que este repositorio
//       va a ser el encargado de llamar al datasource, es decir, no lo vamos a llamar de forma directa sino a través
//       del repositorio yq eue el repositorio es el que va a permitir cambiar el datasource, por ejemplo, al día de
//       mañana ya no quiero traer la información de MovieDB sino de IMDB y gracias a esto puedo hacer el cambio de
//       forma sencilla sin afectar la aplicación y el código, es decir, el cambio debe de ser transparente.
import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MoviesRepository {
  // Peliculas actualmente en cartelera
  Future<List<Movie>> getNowPlaying({int page = 1});

  // Peliculas populares
  Future<List<Movie>> getPopular({int page = 1});
}
