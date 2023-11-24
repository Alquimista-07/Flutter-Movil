// NOTA: La documentación de FlutterFire para el manejo de notificaciones con Firebase la encontramos en:
//       https://firebase.flutter.dev/docs/overview
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_app/config/router/app_router.dart';

import 'package:push_app/config/theme/app_theme.dart';
import 'package:push_app/presentation/blocs/notifications/notifications_bloc.dart';

void main() async {
  // Firebase
  WidgetsFlutterBinding.ensureInitialized();
  // NOTA: Registro manejador de la función para recibir la notificación cuando la aplicación esta terminada
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await NotificationsBloc.initializeFirebaseCloudMessagingNotifications();

  runApp(
      // NOTA: Como queremos que nuestro bloc sea accesible para toda la aplicación, es decir, para todos los widgets entonces lo vamos a colocar
      //       a nivel del main. Y recordemos que nuestros gestores de estado, ya sea bloc, Cubit, Riverpod, Provider los podemos asignar en distintos
      //       niveles de acceso para el árbol de widgets o contexto
      MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => NotificationsBloc(),
      )
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
    );
  }
}