import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    // NOTA: Recordemos que el SafeArea es un widget que usamos para que asigne algo así como el área segura para que el notch
    //       del dispositivo no interfiera en la visualización ni en la funcionalidad, y con esto el notch no nos va a estorbar.
    return SafeArea(
      // NOTA: Le decimos al SafeArea que no considere el bottom o que lo tome en false ya que en iphone con su dynamic island o
      //       dispositivos con un notch bastante pronunciado nos va a colocar un espacio en blanco en el bottom que no se va a
      //       ver bien.
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          // NOTA: Recordemos que el double.infinity es para que de todo el ancho que pueda
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary),
              const SizedBox(width: 5),
              Text('Cinemapedia', style: titleStyle),
              // NOTA: Vamos a usar otro widget que nos ofrece Flutter que es el spacer, el cual
              //       toma el ancho posible para gregar un espacio como lo haríamos con Flexbox
              //       un Flex Layout si estuvieramos trabajando en web.
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  final movieRepository = ref.read(movieRepositoryProvider);

                  // NOTA: Acá vamos a mandar a llamar una función que ya viene en Flutter que se llama showSearch el cual tiene el contexto de la app que ya sabemos
                  //       que tiene el árbol de widgets, y adicionalmente pide un delegate el cual recibe un SearchDelegate de tipo dynamic, por lo tanto, regresa
                  //       algo de cualquier tipo e idealmente lo que voy a querer hacer es regresar el id de la película, o la película entera, según lo que yo necesite.
                  //       Por lo tanto ese SearchDelegate es el que se va a encargar de trabajar la búsqueda.
                  //       Entonces lo que vamos a hacer es crearnos una clase que extienda de ese SearchDelegate
                  showSearch(
                    context: context,
                    // NOTA: Entonces ya como nuestro SearchMovieDelegate tiene un Function la tenemos que pasar y la cual ya la tenemos
                    //       en el MovieRepositoryImpl el cual a la final va a llegar al provider movieRepositoryProvider en si.
                    //       Por lo tanto convertimos este en un ConsumerWidget, agregamos el ref, hacemos el read del provider y recordemos
                    //       que es read porque estamos dentro de un método, y al final mandamos la función  searchMovies pero OJO solo mandamos
                    //       la referencia y no la ejecutamos y recordemos que para mandar la referencia es sin agregarle los ()
                    delegate: SearchMovieDelegate(
                        searchMovies: movieRepository.searchMovies),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
