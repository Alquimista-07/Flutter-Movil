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
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/buttons',
      builder: (context, state) => const ButtonsScreen(),
    ),
    GoRoute(
      path: '/cards',
      builder: (context, state) => const CardsScreen(),
    )
  ],
);
