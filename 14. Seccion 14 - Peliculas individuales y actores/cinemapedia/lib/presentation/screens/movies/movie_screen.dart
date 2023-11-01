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
      // NOTA: Como quiero trabajar con slivers voy a usar un CustomScrollView
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie),
        ],
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    // Obtenemos las dimensiones del dispositivo con el fin de más adelante usar el porcentaje que necesitemos
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7, // 70% de la pantalla
      foregroundColor: Colors.white, // Color del primer plano
      // NOTA: El flexibleSpace es el epacio flexible del nuestro custom AppBar
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        title: Text(
          movie.title,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.start,
        ),
        // NOTA: Congiguración del background que en este caso es una imágen con un stack que como sabemos
        //       este stack nos permite colocar unos widgets encima de otros y la posición depende del orden
        //       por lo tanto entre más abajo este agregado más al frente va a aestar ese widget
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
              ),
            ),

            // NOTA: Vamos a colocar un gradiente para los posters con color claro
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    // NOTA: El begin y el end los asignamos para que el gradiente sea de arriba hacia abajo
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    // NOTA: Ahora como queremos que el gradiente no inicie deste el tope de la pantalla le decimos
                    //       con los stops que inicie en el 70% del espacio asignado y termine en el 100% del espacio
                    //       asignado
                    stops: [0.7, 1.0],
                    // NOTA: Asignamos los colore
                    colors: [
                      Colors.transparent,
                      Colors.black87,
                    ],
                  ),
                ),
              ),
            ),

            // NOTA: Vamos a colocar un gradiente en la sección de la flecha del appbar que sirve para regresar ya que de la misma forma
            //       en algunos posters no se alcanza a apreciar
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    stops: [0.0, 0.3],
                    colors: [
                      Colors.black87,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
