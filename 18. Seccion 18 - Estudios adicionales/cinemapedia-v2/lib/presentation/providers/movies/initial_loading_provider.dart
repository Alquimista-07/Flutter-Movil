// NOTA: Este va a ser el provider que va a estar pendiente de cuando los demás tengan un valor
//       y de esta forma tener una bandera booleana que nos sirva para ocultar el loader de la
//       pantalla inicial.
//       Entonces este provider va a cambiar basado en otros providers

import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// NOTA: En este caso como no ocupamos nada más que regresar un valor booleano entonces vamos a
//       crear un provider inmutable
final initialLoadingProvider = Provider((ref) {
  // Determinamos la carga en base a los otros providers validando si están vacios
  final step1 = ref.watch(nowPlayingMoviesProvider).isEmpty;
  final step2 = ref.watch(popularMoviesProvider).isEmpty;
  final step3 = ref.watch(upcomingMoviesProvider).isEmpty;
  final step4 = ref.watch(topRatedMoviesProvider).isEmpty;

  if (step1 || step2 || step3 || step4) return true;

  // Terminamos de cargar
  return false;
});
