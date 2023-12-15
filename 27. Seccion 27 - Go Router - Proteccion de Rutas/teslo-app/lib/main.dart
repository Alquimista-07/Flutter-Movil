import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/config/config.dart';

void main() async {
  // NOTA: Cargamos el archivo que contiene las variables de entorno
  await Environment.initEnvironment();

  runApp(const ProviderScope(
    child: MainApp(),
  ));
}

// NOTA: Ahora como nuestras rutas las envolvimos en un provider con el fin de ayudarnos a tener acceso para saber si estoy autenticad o no y de esta forma tener la protección de rutas, entonces
//       tenemos que transformar en un ConsumerWidget para tener la referencia al ref y mandar llamar ese provider
class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // NOTA: Referencia al provider que envuelve nuestras rutas
    final appRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      routerConfig: appRouter,
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
