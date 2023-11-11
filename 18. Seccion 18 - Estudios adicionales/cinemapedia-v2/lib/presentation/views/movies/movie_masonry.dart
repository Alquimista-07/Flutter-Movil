// NOTA: Acá vamos a crear nuesta vista con las películas favoritas, estilo Masonry
//       del cual un ejemplo sería la forma como nos muestra pinterest su contenido.
//       El enlace de la documentación lo podemos encontrar en:
//       - https://pub.dev/packages/flutter_staggered_grid_view
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/views/movies/movie_poster_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MovieMasonry extends StatefulWidget {
  final List<Movie> movies;
  final VoidCallback? loadNextPage;

  const MovieMasonry({
    super.key,
    required this.movies,
    this.loadNextPage,
  });

  @override
  State<MovieMasonry> createState() => _MovieMasonryState();
}

class _MovieMasonryState extends State<MovieMasonry> {
  //* Tarea clase 273: Creamos el controlador
  final scrollController = ScrollController();

  //* Tarea clase 273: Creamos el initState
  @override
  void initState() {
    super.initState();
    //* Tarea clase 273: Creamos el listener
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      if ((scrollController.position.pixels + 100) >=
          scrollController.position.maxScrollExtent) {
        // Load next page
        widget.loadNextPage!();
      }
    });
  }

  //* Tarea clase 273: Creamos el dispose
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        controller: scrollController,
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          // NOTA: Ahora para que se vea el estilo de Massonry que es como desordenado vamos a hacer una validación
          //       y darle ese efecto
          if (index == 1) {
            return Column(
              children: [
                const SizedBox(height: 40),
                MoviePosterLink(movie: widget.movies[index]),
              ],
            );
          }

          return MoviePosterLink(movie: widget.movies[index]);
        },
      ),
    );
  }
}
