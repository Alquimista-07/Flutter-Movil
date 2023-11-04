import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

// NOTA: Voy a definirme un tipo de función específica que me va a ayudar a definir el tipo del método
//       searchMovies que voy a crear para que sea llamado por el build buildSuggestions y va a hacer
//       el trabajo de buscar las películas que coincidan con el query.
//       Y por lo tanto ya la función que ese este typedef tiene que cumplir con esta firma
typedef SearcMoviesCallback = Future<List<Movie>> Function(String query);

// NOTA: OJO hay que tener en cuenta que al extender del SearchDelegate nos va a pedir que implementemos cuatro métodos
//       (buildActions, buildLeading, buildResults y buildSuggestions) los cuales al implementarlos nos va a indicar que
//       algunos métodos son opcionales (2 métodos), y otros obligatorios (2 métodos), adicionalmente hay que mirar el tipo
//       de dato que regresan.
// NOTA: Otra cosa que vamos a hacer es que como queremos retornar el objeto movie completo y no solo el id entonces en el
//       extend del SearchDelegate colocamos el objeto y lo dejamos opcional pero como se mencionó podría ser solo el id
//       (String?).
class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearcMoviesCallback searchMovies;

  List<Movie> initialMovies;

  // NOTA: Ahora para el dobounce vamos a usar un stream controller, adicionalmente si queremos tener múltiples listener
  //       usamos el método broadcast, pero OJO eso es solo si no sabemos o necesitamos esos multiples listener de lo contrario
  //       si solo vamos a tener uno simplemente usamos el StreamController
  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  // NOTA: Creamos una nueva propiedad también para el debounce el cual permite determinar un periodo de tiempo, limpiarlo y cancelarlo
  Timer? _debounceTimer;

  SearchMovieDelegate({required this.searchMovies, required this.initialMovies})
      // NOTA: Con este super podemos también cambiar el texto del input del delegate y el nombre del botón de enter del teclado
      : super(
            searchFieldLabel: 'Buscar Película',
            textInputAction: TextInputAction.done);

  // Método para limpiar los streams y que no queden en memoria
  void clearStreams() {
    debouncedMovies.close();
  }

  // Cramos un método para detectar cuando el query cambie
  void _onQueryChanged(String query) {
    if (_debounceTimer?.isActive ?? false) {
      // Lo limpiamos
      _debounceTimer!.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      // NOTA: Como ya estamos almacenando la data en un provider tenemos que limpiar y evitar hacer la petición.
      //       Por lo tanto modificamos en el moviedb_datasource para agregar la validación de si el query esta vacío.
      /*
      // Cuando deja de escribir durante 500 milisegundos
      if (query.isEmpty) {
        // Este add lo hacemos acá para que no se limpie el arreglo y muestre los resultados anteriores
        // pero fácilmente podemos agregarlo al inicio del método y limpiar tan pronto se inicie a escribir
        debouncedMovies.add([]);
        return;
      }
      */

      final movies = await searchMovies(query);
      debouncedMovies.add(movies);
      initialMovies = movies;
    });
  }

  // NOTA: Otra cosa es que nosotros podemos implementar otro override que no es obligatorio al estender del SearchDelegate
  //       pero que nos va a servir para cambiar el texto de la caja de texto para que no diga Search sino lo que nosotros
  //       indiquemos
  // NOTA: Comentamos esta parte ya que en el super del constructor también podemos cambiar esto
  /*
  @override
  String get searchFieldLabel => 'Buscar Película';
  */

  // NOTA: Este es como para contruir las acciones
  @override
  List<Widget>? buildActions(BuildContext context) {
    //return [const Text('BuildActions')];
    return [
      // NOTA: Colocamos un botón para limpiar lo que se escribió pero de forma condicional para que no se muestre si no hay nada
      //       escrito
      //       Entonces en este caso vamos a usar una propiedad que nos ofrece el SearchDelegate que es el query la cual contiene
      //       la información de esa caja de texto, por lo tanto podemos setearle un nuevo valor por ejemplo un valor vacío y de
      //       esta forma ya lo limpiamos

      //if (query.isNotEmpty)
      FadeIn(
        // NOTA: Una propiedad adicional del fadeIn del animate_do es el animate, que es un valor booleano el cual trabaja en vase a una condición
        //       y fácilmente esta reemplazaría al if que teniamos anteriormente
        animate: query.isNotEmpty,
        //duration: const Duration(milliseconds: 200), // Velociadad de la animación
        child: IconButton(
            icon: const Icon(Icons.clear), onPressed: () => query = ''),
      )
    ];
  }

  // NOTA: Este sería como para construir un icono o la parte que esta al inicio del AppBar donde tenemos el título de la aplicación (Cinemapedi)
  @override
  Widget? buildLeading(BuildContext context) {
    //return const Text('BuildLeading');
    // NOTA: En este caso vamos a poner un botón para regresar a la ventana principal
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
      // NOTA: Entonces en este caso ya tenemos a la mano un método que nos ofrece el SearchDelegate que es el close
      //       el cual recibe el context y un result, el result es lo que yo quiero regresar cuando cierre el showsearch.
      //       En este caso como estoy en el buildLeading suponemos que la persona no hizo nada ya que estamos dando atrás
      //       entonces mandamos un null
      onPressed: () {
        // Limpiamos los streams
        clearStreams();
        // Cerramos el SearchDelegate
        close(context, null);
      },
    );
  }

  // NOTA: Este serían los resultados que van a aparecer cuando el usuario persione Enter
  @override
  Widget buildResults(BuildContext context) {
    //return const Text('BuildResults');
    // NOTA: Acá básicamente ocupamos mostrar lo mismo que tenemos en el buildSuggestions por lo tanto podemos reutilizar parte del código
    //       que tenemos allá y hacerle algunas modificaciones ya que se nos presenta un problema es que al ser un Stream, esta cuando demos
    //       enter va a crear un nuevo listener por lo tanto a pesar de que el stream que tenemos en el buildSuggestions ya emitio algo antes
    //       este no ha emitido ningún valor, entonces hay varias formas de solucionarlo la cual una sería llamar el _onQueryChanged antes del
    //       return del stream pero esto haría la petición dos veces, otra sería deshabilitar el enter de alguna forma, otra forma sería con
    //       la propiedad que habíamos definido para tener la lista de initialMovies por lo tanto ya no sería final para poderla cambiar
    return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return _MovieItem(
              movie: movie,
              // NOTA: Como ya creamos la función en nuestro _MovieItem entonces le mandamos la referencia al close del SearchDelegate y ahora como tenemos el
              //       debounce también ocupamos ajustar y mandar el context, adicionalmente también limpiar los streams
              onMovieSelected: (context, movie) {
                clearStreams();
                close(context, movie);
              },
            );
          },
        );
      },
    );
  }

  // NOTA: Este sería para cuando la persona este escribiendo y es el que en este caso vamos a usar ya que la idea es que el usuario
  //       vaya escribiendo y cuando se detenga y pase un tiempo determinado ahí se dispare la petición y se realice la búsqueda.
  @override
  Widget buildSuggestions(BuildContext context) {
    // NOTA: Llamamos la función para el debounce
    _onQueryChanged(query);

    //return const Text('BuildSuggestions');
    // NOTA: Acá vamos a disparar la petición y contruir el widget donde se van a mostrar los resultados.
    //       Ahora el widget que ocupariamos para trabajar y que sirva con un Future. Entonces usaríamos
    //       un FutureBuilder que luego vamos a cambiar por un Streambuilder para implementar el debounce
    // return FutureBuilder(
    //   future: searchMovies(query),
    return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return _MovieItem(
              movie: movie,
              // NOTA: Como ya creamos la función en nuestro _MovieItem entonces le mandamos la referencia al close del SearchDelegate y ahora como tenemos el
              //       debounce también ocupamos ajustar y mandar el context, adicionalmente también limpiar los streams
              onMovieSelected: (context, movie) {
                clearStreams();
                close(context, movie);
              },
            );
          },
        );
      },
    );
  }
}

// NOTA: Widget para mostrar la película
class _MovieItem extends StatelessWidget {
  final Movie movie;

  // Recibimos la función para pasar el contexto y el close que tenemos y que es propio del searchDelegate
  final Function onMovieSelected;

  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    // NOTA: Ahora para que cuando interactuemos haciendo click sobre un item y naveguemos a la película vamos a usar
    //       un widget que ya varias veces lo hemos usado el cual es el GestureDetector el cual tiene su método onTap
    //       que es el encargado de ejecutar la acción que nosotros queramos
    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            //* Image
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) =>
                      FadeIn(child: child),
                ),
              ),
            ),

            const SizedBox(width: 10),

            //* Description
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyles.titleMedium),
                  (movie.overview.length > 100)
                      ? Text('${movie.overview.substring(0, 100)}...')
                      : Text(movie.overview),
                  //* Calificación
                  Row(
                    children: [
                      Icon(
                        Icons.star_half_rounded,
                        color: Colors.yellow.shade800,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        HumanFormats.number(movie.voteAverage, 1),
                        style: textStyles.bodyMedium!
                            .copyWith(color: Colors.yellow.shade900),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
