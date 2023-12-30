import 'package:flutter/material.dart';

import 'package:cinemapedia/config/router/app_router.dart';
import 'package:cinemapedia/config/theme/app_theme.dart';

// NOTA: Importamos el paquete de dotenv que nos ayuda a manejar las variables de entorno, que instalamos y configuramos en nuestro pubspec.yaml
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';

// NOTA: A continuación para usar dotenv debemos convertir el manin en un Future que no retorna nada
Future<void> main() async {
  // NOTA: La siguiente línea de código sirve para la configuración del Splash Screen.
  //       Una cosa que hay que tener en cuenta es que esta línea va a continuar mostrando el splash screen hasta que le indiquemos
  //       que lo remueva con el FlutterNativeSplash.remove(), pero esta instrucción la llamamos cuando nosotros queramos, que sería
  //       cuando la app este lista, por lo tanto podríamos esperar por ejemplo hasta que el HomeView() termine
  //       Adicionalmente para esta configuración podríamos implementar el patron adaptador con un servicio donde centralicemos esto
  //       así como tenemos para el almacenamiento del token en el dispositivo, o el manejo de la cámara y galería en la aplicación
  //       teslo_app de la sección anterior.
  FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

  // NOTA: A continuación con el uso del await inicializamos el paquete y le indicamos el archivo que contiene las variables de entorno..
  //       Y luego ya para usarla es sencillo ya que donde necesitemos usarla solo agregamos dotenv.env['VAR_NAME'];
  await dotenv.load(fileName: '.env');

  // NOTA: Ahora recordemos que para usar riverpod debemos hacer una configuración acá en el runApp y agrega el ProviderScope que es el que va a
  //       contener la referencia a todos los providers de riverpod
  runApp(
    const ProviderScope(child: MainApp()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // NOTA: Importante inicializar la fecha para que no de error al momento de formatearla a través del método
    //       shorDate en el archivo human_formats.dart
    initializeDateFormatting();

    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
    );
  }
}
