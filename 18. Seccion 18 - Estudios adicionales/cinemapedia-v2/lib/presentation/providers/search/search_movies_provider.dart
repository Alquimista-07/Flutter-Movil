// NOTA: Este provider me va a aydar para mantener en memoria el query de búsqueda con el fin de que cuando cerremos
//       el searchDelegate y volvamos a él tengamos lo que buscamos anteriormente
import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedMoviesProvider =
    StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  final movieRepository = ref.read(movieRepositoryProvider);

  // NOTA: Recordemos que tenemos que hacer el return de la instanci
  return SearchedMoviesNotifier(
      searchMovies: movieRepository.searchMovies, ref: ref);
});

// Función personalizada que resuleve un future con una lista de movie
typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  SearchMoviesCallback searchMovies;
  final Ref ref;

  SearchedMoviesNotifier({
    required this.searchMovies,
    required this.ref,
  }) : super([]);

  // NOTA: Ahora esté método a parte de almacenar lo que buscamos nos va a ayudar también a almacenar el término (query) de búsqueda
  //       con el fin de simplificar y quitarle esa tarea al CustomAppBar en la porpiedad searchMovies la cual habíamos modificado para
  //       mandar el query y actualizar el estado del provider searchQueryProvider
  Future<List<Movie>> searchMoviesByQuery(String query) async {
    // NOTA: Estas son las películas que quiero gurarda en mi estado
    final List<Movie> movies = await searchMovies(query);

    // NOTA: Como mencionamos anteriormente acá en esta clase podemos llamar el Ref para hacer referencia y de esta forma poder usarlo
    //       y actualizar el estado del provider que se encarga de almacenar el término buscado anterioremente y así simplificar lo que
    //       teníamos el el CustomAppBar.
    ref.read(searchQueryProvider.notifier).update((state) => query);

    // NOTA: Actualizamos el state, adicionalmente acá no hago un spread como en otros providers y la razón es porque este movies es un nuevo
    //       objeto y no quiero mantener las películas anteriores por lo tanto solo se mantienen las actuales que corresponsen al últomo resultado
    //       de la búsqueda.
    state = movies;

    return movies;
  }
}
