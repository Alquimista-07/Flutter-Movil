// NOTA: Esto es muy similar a como manejamos la películas de forma
//       local (movie_info_provider) por lo tanto podemos copiar y
//       pegar esa clase y ajustarla
import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// NOTA: Creamos el provider deonde el notifier es el ActorsByMovieNotifier y el State es un mapa donde la llave es un String y el value o state
//       es una lista de actores
final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>(
        (ref) {
  final actorsRepository = ref.watch(actorsRepositoryProvider);

  // NOTA: Acá solo pasamos la referencia a la función
  return ActorsByMovieNotifier(getActors: actorsRepository.getActorsByMovie);
});

/*
  La idea es que se consulte el id de la película si ya existe en el listado entonces devuelve el listado de los actores,
  y si no existe voy a realizar la petición para cargar la información.
  {
    '502342': <Actor>[],
    '503543': <Actor>[],
    '504444': <Actor>[],
    '504545': <Actor>[],
  }
*/

// NOTA: Como yo voy a esperar una función que específicamente regrese algo, puedo crearme un nuevo typedef
typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActors;

  // Constructor que regresa un mapa vacío
  ActorsByMovieNotifier({
    required this.getActors,
  }) : super({});

  Future<void> loadActors(String movieId) async {
    // No voy a cargar nada si ya tiene el listado de los actores
    if (state[movieId] != null) return;

    // Si no la tenemos pedimos la data de la película a la API.
    // NOTA: Pero notemos que acá aún no estoy usando la implementación, simplemente estoy definiendolo
    final List<Actor> actors = await getActors(movieId);

    // Y acá viene lo interesante que es hacer la actualización al estado, pero de nuevo voy a crear un nuevo voy a generar
    // un nuevo estado clonando el estado haciendo el spred del estado anterior, y luego el movieId va a apuntar a la movie
    state = {...state, movieId: actors};
  }
}
