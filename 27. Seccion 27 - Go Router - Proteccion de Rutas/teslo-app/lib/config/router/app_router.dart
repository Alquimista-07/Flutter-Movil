import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_shop/features/auth/auth.dart';
import 'package:teslo_shop/features/products/products.dart';

// NOTA: Con la ayuda de reverpod vamos a crear un provider para envolver las rutas y de esta forma ayudarnos con la protección de las rutas dependiendo si estoy
//       autenticado o no , incluso esto se presta para que podamos evitar la construcción de ciertas rutas si no se está autenticado simila a un lazyload en Angular
//       y sería un beneficio de hacerlo de esta forma.
//       OJO Hay una nebulosa con este tema de la protección de rutas ya que en móvil no tenemos una forma de cambiar la ruta a través de una url como se haría en web,
//       a no ser de que tengamos un deep linking o algo parecido y por eso entra en controversia si usar la protección de rutas o no en móvil cosa que en web si es
//       super importante implementarlo, pero en móvil no esta de más agregarlo.
//       Adicionalmente esta forma de proteger rutas nos sirve tanto para web, móvil, escritorio, etc.
final goRouterProvider = Provider((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      //* Primera pantalla
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),

      ///* Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      ///* Product Routes
      GoRoute(
        path: '/',
        builder: (context, state) => const ProductsScreen(),
      ),
    ],

    // NOTA: Bloquear si no se está autenticado de alguna manera
    // NOTA: Ya con esto de envolver en un provider yo ya tengo acceso a si estoy autenticado, si no estoy autenticado, etc, etc,.
    //       y donde vamos a tener que jugar con una propiedad llamada redirect para navegar entre pantallas dependiendo a dicha
    //       autenticación
    redirect: (context, state) {
      return null;
    },
  );
});
