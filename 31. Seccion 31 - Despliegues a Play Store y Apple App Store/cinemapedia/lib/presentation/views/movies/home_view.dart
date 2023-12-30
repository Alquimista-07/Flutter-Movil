// NOTA: Esta va a ser una view pero va a ser parcial la cual va a estar dentro de un widget padre, por lo tanto el concepto de un view o vista
//       no es más que un widget que es muy similar a un widget que sea un screen solo que este es parcial y no ocupa toda la pantalla. Otra cosa
//       es que la vista puede o no tener un scaffold
// NOTA: Por lo tanto lo que vamos a hacer es tomar la vista que teníamos en nuestro home_screen para separarla en su archivo de vista y por lo
//       como antes lo teníamos privado ahora ya no lo va a ser

// NOTA: Ahora ocupamos convertir el widget en un statefulwidget y luego en un ConsumerStatefulWidget con el fin de tener acceso
//       al initstate, esto debido a que queremos que cuando el homeview se cargue yo quiero en el ciclo de vida realizar la carga
//       de la primera página, es decir, usar el initistate
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

// NOTA: Y cono ahora no va a ser un State acá también cambia por un HomeViewState
  @override
  HomeViewState createState() => HomeViewState();
}

// NOTA: Y luego como convertimos de un StatefulWidget a un ConsumerStatefulWidget acá ya no manejamos el state sino un
//       ConsumerState. Y con esto a lo largo de todo este ConsumerState ya tengo acceso al ref de forma global en todo
//       este scope.
class HomeViewState extends ConsumerState<HomeView>
    with AutomaticKeepAliveClientMixin {
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
    super.build(context);

    // NOTA: Mostramos nuestro Full Screen Loader divertido y personalizado.
    //       Ahora hay que tener en cuenta que este loader lo vamos a mostrar der forma condicional ya que necesitamos
    //       estar pendiente de los cuatro providers y validar cuando los cuatro tengan data o algún valor vamos a ocultar
    //       el loader. Y para esto vamos a ocupar hacerlo nuevamente con Riverpod para obtener un valor booleano que me
    //       indique cuando esta listo el provider o providers y cuando no.
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();

    // NOTA: Cuando ya cargue todo podemos remover el Splash Screen
    FlutterNativeSplash.remove();

    // NOTA: Ya como en el modo debugging cuando colocamos el break point el moviedb_datasource
    //       en el return movie del método getNowPlaying nos dimos cuenta de que la data ya se
    //       esta trayendo entonces ahora vamos a renderizarla.
    // OJO: Acá si ya como no me encuentro dentro de un método usamos el recomendado que es el watch
    //      y también porque necesito estar pendiente del estado que va a proporcionar el stateNofier
    //      y con esto ya tenemos un listado de películas en nowPlayingMovies.
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

    // NOTA: Usamos el provider que creamos para cargar solo 6 de las 20 slides de peliculas que nos da la API.
    final slideShowMovies = ref.watch(moviesSliderProvider);

    //* Tarea: Referencia al provider que obtiene las películas que van a estar próximamente
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    //* Tarea: Referencia al provider que obtiene las películas mejor calificadas
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

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
                    // NOTA: Ajuste para tomar la fecha del sistema y darle formato.
                    subTitle: HumanFormats.shortDate(DateTime.now()),
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

  @override
  bool get wantKeepAlive => true;
}
