import 'package:forms_app/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    // NOTA: Ojo este path '/' siempre lo tenemos que crear
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),

    GoRoute(
      path: '/cubits',
      builder: (context, state) => const CubitCounterScreen(),
    ),

    GoRoute(
      path: '/counter-bloc',
      builder: (context, state) => const BlocCounterScreen(),
    ),

    GoRoute(
      path: '/new-user',
      builder: (context, state) => const RegisterScreen(),
    ),
  ],
);
