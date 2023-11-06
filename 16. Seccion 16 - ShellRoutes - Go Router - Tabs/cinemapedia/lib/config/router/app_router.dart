import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  // NOTA: Definimos la pantalla inicial con el path /
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(childView: child);
      },
      routes: [
        //* TAB INICIO
        GoRoute(
            path: '/',
            builder: (context, state) {
              return const HomeView();
            },
            routes: [
              GoRoute(
                path: 'movie/:id',
                name: MovieScreen.name,
                builder: (context, state) {
                  final movieId = state.pathParameters['id'] ?? 'no-id';
                  return MovieScreen(movieId: movieId);
                },
              )
            ]),

        //* TAB FAVORITOS
        GoRoute(
          path: '/favorites',
          builder: (context, state) {
            return const FavoritesView();
          },
        ),
      ],
    ),

    /*
    -------------------------------------
    Rutas Padre/hijo
    -------------------------------------
    Enlaces documentación: 
    - https://pub.dev/documentation/go_router/latest/topics/Configuration-topic.html
    - https://pub.dev/documentation/go_router/latest/go_router/StatefulShellRoute-class.html
    NOTA: Algo importante es que vamos a comentar eso para usar ahora un ShellRoute para la navegación y conserver el estado conocido como KeepAlive, 
          pero OJOOOOOOOOOOOOOOOOOOOOOO esto que vamos a hacer acá en el video de la clase 247 ya esta implementado propiamente en go_router pero al 
          momento de grabar el curso aún no estaba, la documentación de esta funcionalidad la encontramos en el segundo enlace que habla sobre el 
          StatefulShellRoute que es propiamente ese keepAlive. Otra cosa es que esto que vamos a hacer eventualmente lo vamos a terminar quitando y 
          solo es para explicar.
    
    // NOTA: Ahora como nos dimos cuenta que al tomar la url con el id de la pelicula y navegar directamente por esta (Es decir hacer
    //       depp linking) esto causa que perdamos el botón de ir atrás en el appbar y esto es porque la ruta la teníamos como una ruta
    //       principal.
    //       Por lo tanto para solucionar esto y mantenerlo hacemos una configuración en la ruta principal y agregamos la propiedad routes,
    //       que son conocidos como child routes o rutas hijas y ahí es donde vamos a colocar nuestra ruta.
    GoRoute(
      name: HomeScreen.name,
      path: '/',
      // NOTA: Por lo tanto como ahora tenemos nuestra propiedad llamada childView que le indica que vista va a tener entonces necesitamos usarla.
      builder: (context, state) => const HomeScreen(childView: HomeView()),
      routes: [
        // NOTA: Acá vamos a crear una ruta que va a enviar un parámetro para navegar a una película por id
        GoRoute(
          name: MovieScreen.name,
          path: 'movie/:id',
          builder: (context, state) {
            // NOTA: Obtenemos el id que viene por prarámetro
            final movieId = state.pathParameters['id'] ?? 'no-id';

            return MovieScreen(movieId: movieId);
          },
        ),
      ],
    ),
    */
  ],
);
