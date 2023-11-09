import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
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

    // NOTA: Provider de los actores
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
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

          // NOTA: Detalles de la película
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _MovieDetails(movie: movie),
              // NOTA: Para evitar que cree un montón de elementos asignamos el childCount con 1 solo elemento
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

// NOTA: El .autoDispose hace que cuando el widget donde se esta usando el provider se destruye, automáticamente
//       lo deja en su estado inicial.
//       Ej:
//       Provider.autoDispose((ref)
//
//       También tenemos el .family el cual nos permite recibir un argumento y lo podemos definir de cualquier tipo:
//       Ej:
//       Provider.autoDispose((ref)
//
//       Adicionalmente se pueden usar juntos.
//       EJ:
//      Provider.family.autoDispose((ref, arg)
//
// NOTA: Como el toggle del corazón para cambiar a favorito o no es algo que solo voy a ocupar en esta pantalla, entonces lo que voy a hacer es
//       crear el estado o ese pequeño provider que va a regresar un booleano lo voy a tener aquí, pero lo podriamos colocar en los providers, o
//       en otro lado.
//       EL FutureProvider es otro provider de riverpod que podemos ver en la documentación, el cual sirve cuando tenemos algún tipo de tarea
//       asíncrona para que se resuevla y una vez se resuelva obtenemos el valor.
//       Como mencionamos que el family nos permite mandar un argumento, entonces ese nos sive para obtener el id de la película y el aucl necesitamos
//       para hacer la consulta en la base de datos y verificar si es favorita o no. Adicionalmente lo colocamos con el autodispose
final isFavoriteProvider =
    FutureProvider.family.autoDispose((ref, int movieId) {
  // Consultamos en la base de datos
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);

  return localStorageRepository
      .isMovieFavorite(movieId); // Si esta en favoritos
});

class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;
  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // NOTA: Tomamos la instancia del provider que devuelve si es favorito y que recibe el id de la película
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));

    // Obtenemos las dimensiones del dispositivo con el fin de más adelante usar el porcentaje que necesitemos
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7, // 70% de la pantalla
      foregroundColor: Colors.white, // Color del primer plano
      // NOTA: Para colocar el ícono del corazón para agregar a favoritos vamos a agregar la propiedad actions
      actions: [
        IconButton(
            // NOTA: Convertimos la función en asíncrona y le decimos que espere hasta que haga el toggle antes de invalidar el provider
            //       ya que si esto no se algunas veces se hace muy rápido la invalidación y el icono no cambia correctamente dando la
            //       sensación de que no funciona.
            onPressed: () async {
              await ref
                  .watch(localStorageRepositoryProvider)
                  .toggleFavorite(movie);

              // NOTA: Entonces como no vemos que el incono de favorito cambie, sino hasta que salimos y volvemos a entrar, por lo tanto
              //       técnicamete podriamos hacer la petición al provider nuevemten, por lo tanto podemos invalidar el provider para que
              //       vuelva a hacer la petición y confirme.
              ref.invalidate(isFavoriteProvider(movie.id));
            },
            // NOTA: Entonces para cambiar el icono de favorito en base a la consulta del provider vamos a usar un helper method
            //       que es el when que tiene tres proiedades, que es cuando tenemos data, cuando hay un error y cuando se esta
            //       haciendo la petición y le podemos colocar un inicador de progreso, pero este en este caso se va a hacer tan
            //       rápido que no lo vamos a poder ver ya que el acceso a la base de datos es muy rápido.
            icon: isFavoriteFuture.when(
              data: (isFavorite) => isFavorite
                  ? const Icon(Icons.favorite_rounded, color: Colors.red)
                  : const Icon(Icons.favorite_border),
              //error: (error, stackTrace) =>
              error: (_, __) =>
                  throw UnimplementedError(), // Acá podriamos mandar un widget como un Saffold notifier, un snackbar u otro para mostrar el error
              loading: () => const CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ))
      ],
      // NOTA: El flexibleSpace es el epacio flexible del nuestro custom AppBar
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        // NOTA: Comentamos el titulo ya que no cuadra como se ve, más sin embargo lo dejamos como referencia
        // title: Text(
        //   movie.title,
        //   style: const TextStyle(fontSize: 20),
        //   textAlign: TextAlign.start,
        // ),
        // NOTA: Congiguración del background que en este caso es una imágen con un stack que como sabemos
        //       este stack nos permite colocar unos widgets encima de otros y la posición depende del orden
        //       por lo tanto entre más abajo este agregado más al frente va a aestar ese widget
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                // NOTA: Como puede haber un lapso en que la imágen aún no se trae de internet y puede quedar un espacio en blanco mientras se carg
                //       entonces usamos un loading builder para validar si ya se construyo o no y hacer algo mientras se construye y cuano se contruye
                //       hacer la transición sutil con alguna animación.
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),

            // NOTA: Como vemos que el gradiente lo estamos usando en varios lados, entonces hacemos un refactora para crear un widget personalizado
            //       que reciba las propiedades necesarias y nos ayude a evitar copiar y pegar código.
            const _CustomGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.0, 0.2],
              colors: [Colors.black54, Colors.transparent],
            ),

            const _CustomGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.8, 1.0],
              colors: [
                Colors.transparent,
                Colors.black54,
              ],
            ),

            const _CustomGradient(
              begin: Alignment.topLeft,
              stops: [0.0, 0.3],
              colors: [
                Colors.black87,
                Colors.transparent,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;

  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* Imágen
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                ),
              ),
              const SizedBox(width: 10),

              //* Descripción película
              SizedBox(
                // 70% menos los pixeles que asignamos al padding y el anterior sizedbox (que serían 40 aprox.)
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: textStyle.titleLarge,
                    ),
                    Text(movie.overview),
                  ],
                ),
              ),
            ],
          ),
        ),

        //* Generos de la película
        Padding(
          padding: const EdgeInsets.all(8),
          // NOTA: El widget wrap lo que hace es como si tuvieramos una grilla e ir acomodando los elementos automáticamente debajo cuando no
          //       hay espacio disponible en la pantalla
          child: Wrap(
            children: [
              ...movie.genreIds.map(
                (gender) => Container(
                  margin: const EdgeInsets.only(right: 10),
                  // El widget Chip es esas cajitas donde vamos a motrar los géneros de la película y las hacemos que tengan bordes redondeados
                  child: Chip(
                    label: Text(gender),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        //* Mostrar los actores
        _ActorsByMovie(movieId: movie.id.toString()),

        // NOTA: Espacio adicional para que la persona pueda seguir haciendo scroll y vea toda la descripción de la película
        const SizedBox(height: 50),
      ],
    );
  }
}

// NOTA: OJO usamos el ConsumerStatefulWidget solo cuando necesitamos usar el initState para inicializar algo tan pronto sea construido
//       de resto usamos el ConsumerWidget que es básicamente el StatefulWidget solo que el consumer es de Rverpod, adicionalmente el
//       ConsumerStatefulWidget también es el mismo StatefulWidget solo que de riverpod y con la diferencia de que el ConsumerStatefulWidget
//       tiene ese método initState que mencionamos.

//* Actores
class _ActorsByMovie extends ConsumerWidget {
  final String movieId;

  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // NOTA: Escuchamos el provider de actores y ahí ya tengo mi mapa de actores, pero este puede ser nulo entonces hay que validar
    final actorsByMovie = ref.watch(actorsByMovieProvider);

    if (actorsByMovie[movieId] == null) {
      // Si se cumple entonces estoy cargando los actores y mostramos un indicador de progreso
      return const CircularProgressIndicator(strokeWidth: 2);
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
                    child: Image.network(
                      actor.profilePath,
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Nombre Actor
                const SizedBox(height: 5),

                Text(
                  actor.name,
                  maxLines: 2,
                ),

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

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient({
    this.begin = Alignment.topCenter,
    this.end = Alignment.topRight,
    required this.stops,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            // NOTA: El begin y el end los asignamos para que el gradiente sea de arriba hacia abajo
            begin: begin,
            end: end,
            // NOTA: Ahora como queremos que el gradiente no inicie deste el tope de la pantalla le decimos
            //       con los stops que inicie en el 70% del espacio asignado y termine en el 100% del espacio
            //       asignado
            stops: stops,
            // NOTA: Asignamos los colore
            colors: colors,
          ),
        ),
      ),
    );
  }
}
