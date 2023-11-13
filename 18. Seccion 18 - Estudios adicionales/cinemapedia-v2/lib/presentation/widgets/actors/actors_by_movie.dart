import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActorsByMovie extends ConsumerWidget {
  final String movieId;

  const ActorsByMovie({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // NOTA: Escuchamos el provider de actores y ahí ya tengo mi mapa de actores, pero este puede ser nulo entonces hay que validar
    final actorsByMovie = ref.watch(actorsByMovieProvider);

    //* Loading actors
    if (actorsByMovie[movieId] == null) {
      // Si se cumple entonces estoy cargando los actores y mostramos un indicador de progreso
      return Container(
        height: 100,
        margin: const EdgeInsets.only(bottom: 50),
        child: const Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    // NOTA: Acá con el movieId yo ya tengo los actores y ya se que los tengo entonces indicmaos un !
    //       porque ya la evaluación la realizamos antes.
    final actors = actorsByMovie[movieId]!;

    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          final actor = actors[index];

          return Container(
            padding: const EdgeInsets.all(8.0),
            width: 135,
            child: Column(
              // NOTA: Alineamos los el contenido del Column a la izquierda
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Actor Photo
                // NOTA: Adicionalmente le colocamos una animación FadeInRight al carrusel de las fotos de los actores
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FadeInImage(
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                      placeholder:
                          const AssetImage('assets/loaders/bottle-loader.gif'),
                      image: NetworkImage(actor.profilePath),
                    ),
                  ),
                ),

                // Nombre Actor
                const SizedBox(height: 5),

                Text(actor.name, maxLines: 2),

                Text(
                  actor.character ?? '',
                  maxLines: 2,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  // La propiedad Overflow va a hacer es que si el texto es muy largo va a colocar ...
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
