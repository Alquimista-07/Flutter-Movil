import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// NOTA: Ahora como tenemos un provider con Riverpod tenemos que transformarlo en un ConsumerStatefulWidget
class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';

  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  // NOTA: De la misma forma como tenemos el provider con Riverpod acá también cambiamos
  @override
  MovieScreenState createState() => MovieScreenState();
}

// NOTA: Y de la misma manera como tenemos el provider de Riverpod acá cambiamos por un ConsumerState
class MovieScreenState extends ConsumerState<MovieScreen> {
  // NOTA: Vamos a usar el initstate para saber cuando estoy cargando, cuando termino de cargar, entre otras
  //       cosas. Adicionalmente vamos a manejar un cache local para también mostrar un loading y para hacer
  //       más eficiente la aplicación y no hacer una petición nuevamente si ya anteriormente habíamos ingresado
  //       a ver la información de esa película
  @override
  void initState() {
    super.initState();

    // NOTA: Recordemos que cuando estamos dentro de un método no usamos el watch sino el read
    //       Adicionalmente como estamos dentro del state para hacer referencia a una propiedad
    //       usamos la palabra widget
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    // NOTA: Cuando colocamos movieInfoProvider)[widget.movieId] estoy diciendo del mapa quiero que busque
    //       el elemento en la posición [widget.movieId]
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    // NOTA: Si no tenemos la movie sabemos que estamos haciendo la petición http entonces colocamos por ejemplo
    //       un progress para indicar que se esta cargando algo
    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('MovieID: ${widget.movieId}'),
      ),
    );
  }
}
