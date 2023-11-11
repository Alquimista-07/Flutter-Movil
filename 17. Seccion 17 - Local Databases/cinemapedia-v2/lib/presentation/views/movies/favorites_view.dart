// NOTA: Esta va a ser una view pero va a ser parcial la cual va a estar dentro de un widget padre, por lo tanto el concepto de un view o vista
//       no es más que un widget que es muy similar a un widget que sea un screen solo que este es parcial y no ocupa toda la pantalla. Otra cosa
//       es que la vista puede o no tener un scaffold
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/views/movies/movie_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

//* Tarea clase 271
// NOTA: Es necesario primero convertir en un statefulwidget para la luego nuevamente convertirlo en un consumerstatefulwidget
//       esto con el fin de que al crear el statefulwidget nos cree automáticamete el método createState. Adicionalmente la
//       razón de convertirlo en un consumerstatefulwidget es porque necesitamos tener acceso al state notifier del provider de
//       favoritos de riverpod.
class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLastPage = false;
  bool isLoading = false;

  //* Tarea clase 271
  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  //* Tarea clas 273
  void loadNextPage() async {
    if (isLoading || isLastPage) return;

    isLoading = true;

    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();

    isLoading = false;

    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    //* Tarea clase 271
    // NOTA: Como el favoriteMovies es un mapa<int, movie> entonces esto lo necesitamos transformar a una lista
    //       y esto podemos hacerlo con un ciclo for, pero hay una forma más sencilla que es tomando el values y
    //       convirtiendolo a una lista con el método toList()
    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();

    if (favoriteMovies.isEmpty) {
      final colors = Theme.of(context).colorScheme;

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_outline_sharp,
              size: 60,
              color: colors.primary,
            ),
            Text(
              'Ohhh no!!!',
              style: TextStyle(fontSize: 30, color: colors.primary),
            ),
            const Text(
              'No tienes películas favoritas.',
              style: TextStyle(fontSize: 20, color: Colors.black45),
            ),
            const SizedBox(height: 20),
            FilledButton.tonal(
              onPressed: () => context.go('/home/0'),
              child: const Text('Empieza a buscar'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: MovieMasonry(
        loadNextPage: loadNextPage,
        movies: favoriteMovies,
      ),
    );
  }
}
