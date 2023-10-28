// NOTA: Para crear este Slider lo podríamos hacer desde cero pero en este caso ya existe un paquete
//       llamado card_swiper que lo encontramos en https://pub.dev/packages/card_swiper y que nos sirve
//       bastante para lo que queremos hacer.
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

class MoviesSlideshow extends StatelessWidget {
  // NOTA: Vamos a necesitar un listado de películas
  final List<Movie> movies;

  const MoviesSlideshow({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      width: double.infinity,
      child: Swiper(
        // NOTA: El viewportFraction hace que el slide muestre un pedazo del anterior y del siguiente slide
        viewportFraction: 0.8,
        // NOTA: El scale hace que los slide sean un poquito más pequeños
        scale: 0.9,
        // NOTA: El autoplay hace que los slides vayan cambiando automáticamente
        autoplay: true,
        itemCount: movies.length,
        itemBuilder: (context, index) => _Slide(movie: movies[index]),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
