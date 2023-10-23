import 'package:flutter/material.dart';
import 'package:widgets_app/config/router/app_router.dart';
import 'package:widgets_app/config/theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // NOTA: Como se había mencionado anteriormente la forma más sencilla y reomendada para el enrutamiento es usar go_router por lo tanto
    //       comentamos el código que habíamos creando anteriormente con la propiedad routes y ahora vamos a usar nuestra configuración de
    //       rutas usando go_router.
    //       Ahora para pasar nuetra configuraciónde router agregamos el método .router al MaterialApp
    return MaterialApp.router(
      title: 'Flutter Widgets',
      // NOTA: Pasamos el router config
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 5).getTheme(),
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
