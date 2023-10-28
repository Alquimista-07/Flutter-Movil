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
      body: Center(
        child: _HomeView(),
      ),
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
  }

  @override
  Widget build(BuildContext context) {
    // NOTA: Ya como en el modo debugging cuando colocamos el break point el moviedb_datasource
    //       en el return movie del método getNowPlaying nos dimos cuenta de que la data ya se
    //       esta trayendo entonces ahora vamos a renderizarla.
    // OJO: Acá si ya como no me encuentro dentro de un método usamos el recomendado que es el watch
    //      y también porque necesito estar pendiente del estado que va a proporcionar el stateNofier
    //      y con esto ya tenemos un listado de películas en nowPlayingMovies.
    //final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

    // NOTA: Usamos el provider que creamos para cargar solo 6 de las 20 slides de peliculas que nos da la API.
    final slideShowMovies = ref.watch(moviesSliderProvider);

    return Column(
      children: [
        const CustomAppbar(),
        MoviesSlideshow(movies: slideShowMovies),
      ],
    );
  }
}
