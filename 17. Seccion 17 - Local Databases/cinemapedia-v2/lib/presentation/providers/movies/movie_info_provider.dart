// NOTA: Creamos un provider que se va a encargar de llamar a la implementación, y OJO esto es importante ya que no es tarea del widget
//       llamar las implementaciones sino que esa es tarea del provider.
//       Ahora lo que este provider va a hacer es crear un cache local para evitar hacer peticiones a la API innecesarias si ya habíamos
//       visualizado la información de una película.

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// NOTA: Creamos el provider
final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);

  // NOTA: Acá solo pasamos la referencia a la función ya que si quisieramos llamar la función colocaríamos los getMovieById()
  //       y le pasaríamos el id
  return MovieMapNotifier(getMovie: movieRepository.getMovieById);
});

/*
  La idea es que se consulte el id si ya existe en el mapa entonces devuelve la movie,
  y si no existe voy a realizar la petición para cargar la información.
  {
    '502342': Movie(),
    '503543': Movie(),
    '504444': Movie(),
    '504545': Movie(),
  }
*/

// NOTA: Como yo voy a esperar una función que específicamente regrese algo, puedo crearme un nuevo typedef
typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovie;

  // Constructor que regresa un mapa vacío
  MovieMapNotifier({required this.getMovie}) : super({});

  Future<void> loadMovie(String movieId) async {
    // No voy a cargar nada si ya la tiene, adicionalmente podríamos colocar una fecha y si ya la fecha cambio traemos
    // la data nuevamente dese la API y habrían muchas cosas que podríamos hacer
    if (state[movieId] != null) return;

    print('Realizando petición HTTP');

    // Si no la tenemos pedimos la data de la película a la API.
    // NOTA: Pero notemos que acá aún no estoy usando la implementación, simplemente estoy definiendolo
    final movie = await getMovie(movieId);

    // Y acá viene lo interesante que es hacer la actualización al estado, pero de nuevo voy a crear un nuevo voy a generar
    // un nuevo estado clonando el estado haciendo el spred del estado anterior, y luego el movieId va a apuntar a la movie
    state = {...state, movieId: movie};
  }
}
