import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

final favoriteMoviesProvider =
    StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return StorageMoviesNotifier(localStorageRepository: localStorageRepository);
});

/*
  {
    1234: Movie,
    7567: Movie,
    4536: Movie,
    1456: Movie,
  }
*/

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  // NOTA: Ocupo sabe la página
  int page = 0;

  // NOTA: No importa que fuente de datos (base de datos) estemos usando este es el repositorio que va a llamar al datasource
  final LocalStorageRepository localStorageRepository;

  StorageMoviesNotifier({
    required this.localStorageRepository,
  }) : super({});

  // NOTA: Cargar las siguiente películas
  Future<List<Movie>> loadNextPage() async {
    final movies = await localStorageRepository.loadMovies(offset: page * 10);
    page++;

    // NOTA: Actualizamos el estado cuando la pagina incremento y actualizo los items
    //       El estado es un mapa de películas, pero recordemos que el movies es una lista
    //       por lo tanto tenemos que hacer la conversión a un mapa antes de actualizar el
    //       estado, para la conversión podemos hacer un foreach pero acá no es recomendado
    //       entonces lo vamos a hacer con un for
    final tempMoviesMap = <int, Movie>{};

    for (final movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }

    state = {...state, ...tempMoviesMap};

    return movies;
  }
}
