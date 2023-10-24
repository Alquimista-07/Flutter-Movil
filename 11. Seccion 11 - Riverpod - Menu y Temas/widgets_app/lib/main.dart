import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/router/app_router.dart';
import 'package:widgets_app/config/theme/app_theme.dart';
import 'package:widgets_app/presentation/providers/theme_provider.dart';

void main() {
  //  NOTA: Para usar el gestor de estado Riverpod provider necesitamos acá en el puro inicio de la aplicación usar el widget ProviderScope, el cual es un
  //        tipo widget especial el cual va a mantener una referencia a todos los providers que usemos
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TAREA: Implementar y escuchar los providers de Riverpod para actualizar el color del tema y cambiar entre el modo claro y obscuro
    final bool isDarkMode = ref.watch(isDarkmodeProvider);
    final int selectedColor = ref.watch(selectedColorProvider);

    // NOTA: Como se había mencionado anteriormente la forma más sencilla y reomendada para el enrutamiento es usar go_router por lo tanto
    //       comentamos el código que habíamos creando anteriormente con la propiedad routes y ahora vamos a usar nuestra configuración de
    //       rutas usando go_router.
    //       Ahora para pasar nuetra configuraciónde router agregamos el método .router al MaterialApp
    return MaterialApp.router(
      title: 'Flutter Widgets',
      // NOTA: Pasamos el router config
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: selectedColor, isDarkMode: isDarkMode)
          .getTheme(),
      // NOTA: El home también lo removimos debido a que la referencia la estamos manejando en nuestra configuración de rutas
      //       con go_router
      /*
      home: const HomeScreen(),
      */
      // NOTA: Esto hace parte de la segunda forma que se explico de como hacer navegación entre pantallas y que se codifico en el home_screend.dart
      // NOTA: Acá podemos definir las rutas como se haría en web pero esto tiene una limitante, ya que por ejemplo no podemos mandar argumentos
      //       y por lo tanto aunque podemos hacerlo así existen mejores formas de hacer esto como el go_router, que lo veremos más
      //       adelante, pero de momento esto es para fines ilustrativos.
      /*
      routes: {
        '/buttons': (context) => const ButtonsScreen(),
        '/cards': (context) => const CardsScreen(),
      },
      */
    );
  }
}
