// NOTA: Como este provider solo va a mostrar de 0 a 6 películas en el slider, entonces
//       este provider lo vamos a crear de solo lectura.3

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'movies_providers.dart';

final moviesSliderProvider = Provider<List<Movie>>((ref) {
  // NOTA: Buscamos el provider que nos trae las peliculas que están actualemente en cartelera, y esto lo hacemos
  //       gracias al ref ya que como tal Riverpord tiene referencia a ese provider.
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

  if (nowPlayingMovies.isEmpty) return [];

  // NOTA: Regresamos una sublista solo de 0 a 6 elementos para no mostrar los 20 slides en el carusel y que nos entrega
  //       la petición a la API.
  return nowPlayingMovies.sublist(0, 6);
});
