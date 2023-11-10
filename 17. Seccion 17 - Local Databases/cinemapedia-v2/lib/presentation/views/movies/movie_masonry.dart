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
  // TODO: init state

  // TODO: dispose

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
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
