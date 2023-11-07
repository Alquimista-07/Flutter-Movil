import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  // NOTA: Acá para el tema de las otras vistas y el KeepAlive para mantener el estado vamos a tener que hacer algunos ajustes al router
  initialLocation: '/home/0',
  routes: [
    // NOTA: Ahora como nos dimos cuenta que al tomar la url con el id de la pelicula y navegar directamente por esta (Es decir hacer
    //       depp linking) esto causa que perdamos el botón de ir atrás en el appbar y esto es porque la ruta la teníamos como una ruta
    //       principal.
    //       Por lo tanto para solucionar esto y mantenerlo hacemos una configuración en la ruta principal y agregamos la propiedad routes,
    //       que son conocidos como child routes o rutas hijas y ahí es donde vamos a colocar nuestra ruta.
    // NOTA: Ahora como queremos hacer que se preserve el estado completo de la vista necesitamos hacer algunos cambios acá en el router
    //       y también como ahora vamos a tener las otras vistas correspondientes a los tabs necesitamos de alguna forma pasar esas
    //       referencias a las vistas a través de un parámetro page.
    GoRoute(
      name: HomeScreen.name,
      path: '/home/:page',
      builder: (context, state) {
        final pageIndex = state.pathParameters['page'] ?? '0';

        // NOTA: Y recordemos que este index tiene que ser numérico por lo tanto lo parseamos para convertirlo ya que en el
        //       parámetro viene como un String
        return HomeScreen(pageIndex: int.parse(pageIndex));
      },
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
    GoRoute(
      path: '/',
      redirect: (_, __) => '/home/0',
    )
  ],
);
