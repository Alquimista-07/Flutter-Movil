// NOTA: Archivo de configuración de rutas
// NOTA: La documentación oficial del go_router la encontramos en la url: https://pub.dev/packages/go_router
//       en la sección API Reference.
import 'package:go_router/go_router.dart';

// NOTA: Adicionalmente como ahora tenemos nuestro archivo de barril que se encarga de exportar las screens
//       nuestras importaciones no se van a extender ya que ahora importamos nuestras screens desde un solo
//       lugar que es nuestro screens.dart que es nuestro archivo de barril.
import 'package:widgets_app/presentation/screens/screens.dart';

// GoRouter configuration
final appRouter = GoRouter(
  // NOTA: Con el initialLocation definimos la primera ruta y la cual se va a mostrar por defecto al iniciar
  initialLocation: '/',
  routes: [
    GoRoute(
      // NOTA: Esta propieada name, es para cuando queremos hacer enrutamiento por nombre que en este caso lo colocamos
      //       pero en si no lo usamos, sino que simplemente lo estamos haciendo para fines ilustrativos y tener en cuenta.
      //       que existe esta cuarta forma de hacer dicho enrutamiento
      name: HomeScreen.name,
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: ButtonsScreen.name,
      path: '/buttons',
      builder: (context, state) => const ButtonsScreen(),
    ),
    GoRoute(
      name: CardsScreen.name,
      path: '/cards',
      builder: (context, state) => const CardsScreen(),
    ),
    GoRoute(
      name: ProgressScreen.name,
      path: '/progress',
      builder: (context, state) => const ProgressScreen(),
    ),
    GoRoute(
      name: SnackbarScreen.name,
      path: '/snackbars',
      builder: (context, state) => const SnackbarScreen(),
    ),
    GoRoute(
      name: AnimatedScreen.name,
      path: '/animated',
      builder: (context, state) => const AnimatedScreen(),
    ),
    GoRoute(
      name: UiControlsScreen.name,
      path: '/ui-controls',
      builder: (context, state) => const UiControlsScreen(),
    ),
    GoRoute(
      name: AppTutorialScreen.name,
      path: '/tutorial',
      builder: (context, state) => const AppTutorialScreen(),
    ),
    GoRoute(
      name: InfiniteScrollScreen.name,
      path: '/infinite',
      builder: (context, state) => const InfiniteScrollScreen(),
    ),
    GoRoute(
      name: CounterScreen.name,
      path: '/counter-river',
      builder: (context, state) => const CounterScreen(),
    ),
    GoRoute(
      name: ThemeChangerScreen.name,
      path: '/theme-changer',
      builder: (context, state) => const ThemeChangerScreen(),
    )
  ],
);
