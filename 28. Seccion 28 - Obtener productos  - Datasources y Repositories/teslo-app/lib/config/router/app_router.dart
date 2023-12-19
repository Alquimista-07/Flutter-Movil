import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_shop/config/router/app_router_notifier.dart';
import 'package:teslo_shop/features/auth/auth.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/products/products.dart';

// NOTA: Con la ayuda de reverpod vamos a crear un provider para envolver las rutas y de esta forma ayudarnos con la protección de las rutas dependiendo si estoy
//       autenticado o no , incluso esto se presta para que podamos evitar la construcción de ciertas rutas si no se está autenticado simila a un lazyload en Angular
//       y sería un beneficio de hacerlo de esta forma.
//       OJO Hay una nebulosa con este tema de la protección de rutas ya que en móvil no tenemos una forma de cambiar la ruta a través de una url como se haría en web,
//       a no ser de que tengamos un deep linking o algo parecido y por eso entra en controversia si usar la protección de rutas o no en móvil cosa que en web si es
//       super importante implementarlo, pero en móvil no esta de más agregarlo.
//       Adicionalmente esta forma de proteger rutas nos sirve tanto para web, móvil, escritorio, etc.
final goRouterProvider = Provider((ref) {
  // NOTA: Referencia al notifier provider
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    // NOTA: Como ocupamos saber cuando el estado de no autenticado cambie a autenticado ahí es un paso donde el redirect no va a suceder a menos de que forzadamente mandaramos
    //       a llamar un context.go() pero no lo vamos a hacer de esa forma. Entonces cuando pasemos de ese estado no autenticado a autenticado tenemos que hacer que el go_router
    //       de alguna manera se de cuenta de ese cambio, entonces para esto existe una propiedad llamada refreshListenable el cual cuando cambie va a volver a evaluar el redirect
    //       por lo tanto en el refreshListenable tenemos que conectar algo que este pendiente del estado de la autenticación para que cuando esta cambie se de cuenta y evalue ese
    //       redirect. Entonces para lograr hacer el refreshListenable el cual espera algo de tipo ChangeNotifier entonces para esto vamos a necesitar implementar un ChangeNotifier
    //       que fue el primer gestor de estado que vimos con Provider al inicio del curos y el cual no es más que una clase que ya trae Flutter y no es necesario instalar nada
    refreshListenable: goRouterNotifier,
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
      GoRoute(
        path: '/product/:id',
        builder: (context, state) => ProductScreen(
          productId: state.params['id'] ?? 'no-id',
        ),
      ),
    ],

    // NOTA: Bloquear si no se está autenticado de alguna manera
    // NOTA: Ya con esto de envolver en un provider yo ya tengo acceso a si estoy autenticado, si no estoy autenticado, etc, etc,.
    //       y donde vamos a tener que jugar con una propiedad llamada redirect para navegar entre pantallas dependiendo a dicha
    //       autenticación
    redirect: (context, state) {
      // NOTA: Recordemos que al imprimir el state dentro de dicho objeto tenemos una propiedad subloc que contiene la ruta
      final isGoingTo = state.subloc;
      // NOTA: Obtenemos si esta autenticado o no
      final authStatus = goRouterNotifier.authStatus;

      // print('GoRouter authStatus: $authStatus, isGoingTo: $isGoingTo');

      // NOTA: Si va al splash y el estado es checking lo dejamos pasar
      if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) {
        return null;
      }

      // NOTA: Si no esta autenticado y quiere ir al login o el registro entonces lo dejamos pasar
      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/register') return null;

        // NOTA: Si no esta autenticado y quiere ir a otra pantalla que no es pública no lo dejamos pasar
        //       ya que las únicas rutas públicas son register o login, entonces en esta caso lo sacamos
        //       al login
        return '/login';
      }

      // NOTA: Si ya esta autenticado y por alguna razón va a navegar al login o al register entonces no lo dejamos
      //       ir a esas rutas y lo mandamos a la url / de la aplicación que es el de productos. Y esto lo hacemos
      //       para que el usuario no tenga una falsa impresión de que no esta autenticado.
      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/register' ||
            isGoingTo == '/splash') {
          return '/';
        }
      }

      return null;
    },
  );
});
