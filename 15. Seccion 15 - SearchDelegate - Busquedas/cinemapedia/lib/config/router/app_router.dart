import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  // NOTA: Definimos la pantalla inicial con el path /
  initialLocation: '/',
  routes: [
    // NOTA: Ahora como nos dimos cuenta que al tomar la url con el id de la pelicula y navegar directamente por esta (Es decir hacer
    //       depp linking) esto causa que perdamos el botón de ir atrás en el appbar y esto es porque la ruta la teníamos como una ruta
    //       principal.
    //       Por lo tanto para solucionar esto y mantenerlo hacemos una configuración en la ruta principal y agregamos la propiedad routes,
    //       que son conocidos como child routes o rutas hijas y ahí es donde vamos a colocar nuestra ruta.
    GoRoute(
      name: HomeScreen.name,
      path: '/',
      builder: (context, state) => const HomeScreen(),
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
  ],
);
