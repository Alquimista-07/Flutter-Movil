import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      // NOTA: Acá vamos a agregar el bottom navigation bar, y sobre el cual podemos ver un ejemplo en el
      //       siguiente enlace: https://www.youtube.com/watch?v=HB5WMcxAmQQ&ab_channel=FernandoHerrera
      //       si queremos saber más de él.
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

// NOTA: Ahora ocupamos convertir el widget en un statefulwidget y luego en un ConsumerStatefulWidget con el fin de tener acceso
//       al initstate, esto debido a que queremos que cuando el homeview se cargue yo quiero en el ciclo de vida realizar la carga
//       de la primera página, es decir, usar el initistate
class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

// NOTA: Y cono ahora no va a ser un State acá también cambia por un HomeViewState
  @override
  _HomeViewState createState() => _HomeViewState();
}

// NOTA: Y luego como convertimos de un StatefulWidget a un ConsumerStatefulWidget acá ya no manejamos el state sino un
//       ConsumerState. Y con esto a lo largo de todo este ConsumerState ya tengo acceso al ref de forma global en todo
//       este scope.
class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    // OJO: Acá usamos el read porque me encuentro dentro de un método y no usamos el watch
    //      Y obtenemos el método loadNextPage
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();

    //NOTA: Hacemos referencia nuestro provider para obtener las pelpiculas populares
    ref.read(popularMoviesProvider.notifier).loadNextPage();

    //* Tarea: Referencia al provider que obtiene las películas que van a estar próximamente
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();

    //* Tarea: Referencia al provider que obtiene las películas mejor calificadas
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    // NOTA: Ya como en el modo debugging cuando colocamos el break point el moviedb_datasource
    //       en el return movie del método getNowPlaying nos dimos cuenta de que la data ya se
    //       esta trayendo entonces ahora vamos a renderizarla.
    // OJO: Acá si ya como no me encuentro dentro de un método usamos el recomendado que es el watch
    //      y también porque necesito estar pendiente del estado que va a proporcionar el stateNofier
    //      y con esto ya tenemos un listado de películas en nowPlayingMovies.
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

    // NOTA: Usamos el provider que creamos para cargar solo 6 de las 20 slides de peliculas que nos da la API.
    final slideShowMovies = ref.watch(moviesSliderProvider);

    // NOTA: Hacemos referencia nuestro provider para obtener las pelpiculas populares
    final popularMovies = ref.watch(popularMoviesProvider);

    //* Tarea: Referencia al provider que obtiene las películas que van a estar próximamente
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    //* Tarea: Referencia al provider que obtiene las películas mejor calificadas
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    // NOTA: Mostramos nuestro Full Screen Loader divertido y personalizado.
    // TODO: Cuando ya haya cargado ocultamos el loader
    return const FullScreenLoader();

    // NOTA: Como al ir agregando hijos va a llegar a un punto donde se va a desbordar de la pantalla, y darnos un warning o error
    //       debido a esto y no permite hacer Scroll, entonces para corregir esto del desbordamiento y que permita hacer scroll,
    //       podríamos usar un widget que anteriormente usamos que es el SingleChildScrollView. Peeeero en este caso como queremos
    //       usar un sliver por lo tanto vamos a usar un nuevo widget llamado CustomScrollView ya que los slivers lo necesitan para
    //       trabajar.
    // NOTA: Los slivers sonara algo complicado pero básicamente son por decirlo así comportamientos de los scrollview, son widgets especiales para el
    //       comportamiento con el scroll, por ejemplo que una barra de navegación o búsqueda se oculte cuando estamos bajando pero tan pronto empezamos
    //       a subir esta automáticamente se muestra y no tienemos que ir hasta el tope de la pantalla para poderla ver.
    return CustomScrollView(
      // NOTA: El CustomScrollView en lugar de tener un child tiene son los slivers que son widgets que tienen esa configuración y característica de ser
      //       un sliver y que trabaja directamente con el scrollview
      slivers: [
        // NOTA: Por lo tanto el CustomAppbar() ya no va a formar parte del Column y ListView como tieníamos anteriormente sino que ahora se va a convertir en un
        //       widget que hace parte del CustomScrollView llamado SliverAppbar() que va a recibir ese CustomAppbar().
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
          ),
        ),

        // NOTA: Ahora acá vamos a hacer un pequeño tuco para mostrar lo que teníamos anteriormente usando un SliverList, el cual recibe una propiedad llamada
        //       delegate que no es más que la función que va a servir para crear los slivers o widget dentro del ListView
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
                  // NOTA: Mostramos el SlideShow
                  MoviesSlideshow(movies: slideShowMovies),

                  // NOTA: Mostramos el infinite ListView horizontal
                  MovieHorizontalListView(
                    movies: nowPlayingMovies,
                    title: 'En Cines',
                    subTitle: 'Viernes 28',
                    loadNextPage: () {
                      //print('Llamado del padre');
                      ref
                          .read(nowPlayingMoviesProvider.notifier)
                          .loadNextPage();
                    },
                  ),

                  MovieHorizontalListView(
                    movies: upcomingMovies,
                    title: 'Próximamente',
                    subTitle: 'En este mes',
                    loadNextPage: () {
                      ref.read(upcomingMoviesProvider.notifier).loadNextPage();
                    },
                  ),

                  MovieHorizontalListView(
                    movies: popularMovies,
                    title: 'Populares',
                    loadNextPage: () {
                      ref.read(popularMoviesProvider.notifier).loadNextPage();
                    },
                  ),

                  MovieHorizontalListView(
                    movies: topRatedMovies,
                    title: 'Mejor Calificadas',
                    subTitle: 'Desde siempre',
                    loadNextPage: () {
                      ref.read(topRatedMoviesProvider.notifier).loadNextPage();
                    },
                  ),

                  const SizedBox(height: 10),
                ],
              );
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }
}
