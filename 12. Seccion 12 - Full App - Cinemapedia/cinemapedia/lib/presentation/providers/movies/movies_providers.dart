// NOTA: Acá voy a crear una clase que me permita a mí la reutilización, y únicamente cambiar el caso de uso
//       que sería la forma en como nosotros vamos a pedir la información. Y lo quw básicamente nosotros queremos
//       crear es que basado en los principios SOLID nuestras clases deberian ser fácilmente extendibles pero
//       cerradas a la modificación

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// NOTA: Este nowPlayingMoviesProvider lo que va a hacer es que cuando yo necesite saber cuales son las películas
//       que están actualmente en cartelera pudo consultar este provider para obtener esa información.
//       Otra cosa es que este StateNotifierProvider es un proveedor que notifica su estado. Adicionalmente a este
//       StateNotifierProvider le indicamos que el notifier va a ser un MoviesNotifier y la data o state que fluye
//       a través de él es un listado de Movie.
//       Por lo tanto básicamente el StateNotifierProvider es una clase que sirve para manejar el estado y hay que
//       tratar de que sea lo más simple posible y esto va a ayudar a que sea simple de leer y mantener.
final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  // NOTA: Acá tengo que proporcionar la función de fetchMoreMovies que necesita el MoviesNotifier, pero de ¿dónde
  //       voy a obtener esa funicón? Esa función yo la tengo en mi MoviesRepositoryImpl que a su ves la tenemos
  //       en el movieRepositoryProvider. Y recordemos que lo hacemos con watch y no con read porque es lo recomendado
  //       y extreaemos la referencia a la función getNowPlaying que es lo que necesitamos.
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies,
  );
});

// NOTA: Acá especificamos el tipo de función que espera, y el objetivo de esto es implemente definir el caso de uso
//       para que el MoviesNotifier para cargar las siguientes pelpiculas simplemente va a recibir esta función.
typedef MovieCallback = Future<List<Movie>> Function({int page});

// NOTA: El StateNotifier va a pedir que tipo de estado es el que yo voy a mantener dentro de él, en este caso es un
//       listado de Movie.
//       OJO Esta clase la llamamos MoviesNotifier y no NowPlayingMoviesNotifier por ejemplo y esto es porque queremos
//       que quede de forma genérica y sirva para mis otros providers
class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  MovieCallback fetchMoreMovies;

  // NOTA: Ahora el constructor lo creamos de la siguiente manera y le decimos que su estado inicial es un arreglo vacío
  //       ya que al inicio no voy a tener ninguna movie,  a menos de que ya tengamos grabado esto en una base de datos
  //       en el dispositivo físic y lo creamos de esa manera pero al inicio no tenemos nada. Es más lo ideal sería tener
  //       un método que cargue de la base de datos, pero más adelante veremos como hacer una información persistente en el
  //       dispositivo.
  MoviesNotifier({
    required this.fetchMoreMovies,
  }) : super([]);

  // NOTA: EL objetivo de este es hacerle alguna modificación al estate (Recordemos que el state es un litado de movie)
  Future<void> loadNextPage() async {
    currentPage++;

    final List<Movie> movies = await fetchMoreMovies(page: currentPage);

    // NOTA: Ahora el objetivo va a ser regresr un nuevo estado, entonces voy a regresar el estado actual con todas la películas así con
    //       operador spred y también voy a hacer el spred de las movies que vengan en la petición. Y con esto riverpod se va a encargar
    //       de notificarlo
    state = [...state, ...movies];
  }
}
