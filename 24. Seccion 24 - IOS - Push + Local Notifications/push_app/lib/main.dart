// NOTA: La documentación de FlutterFire para el manejo de notificaciones con Firebase la encontramos en:
//       https://firebase.flutter.dev/docs/overview
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_app/config/local_notifications/local_notifications.dart';
import 'package:push_app/config/router/app_router.dart';

import 'package:push_app/config/theme/app_theme.dart';
import 'package:push_app/presentation/blocs/notifications/notifications_bloc.dart';

void main() async {
  // Firebase
  WidgetsFlutterBinding.ensureInitialized();
  // NOTA: Registro manejador de la función para recibir la notificación cuando la aplicación esta terminada
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await NotificationsBloc.initializeFirebaseCloudMessagingNotifications();

  // Llamado inicialización local notifications
  await LocalNotifications.initializeLocalNotifications();

  runApp(
      // NOTA: Como queremos que nuestro bloc sea accesible para toda la aplicación, es decir, para todos los widgets entonces lo vamos a colocar
      //       a nivel del main. Y recordemos que nuestros gestores de estado, ya sea bloc, Cubit, Riverpod, Provider los podemos asignar en distintos
      //       niveles de acceso para el árbol de widgets o contexto
      MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => NotificationsBloc(
          // Mandamos solo la referencia a la función para obtener permisos y que creamos para quitar la dependencia oculta
          requestLocalNotificationsPermissions:
              LocalNotifications.requestPremissionLocalNotifications,
          // Mandamos solo la referencia a la función para obtener mostrar la local notification y que creamos para quitar la dependencia oculta
          showLocalNotification: LocalNotifications.showLocalNotification,
        ),
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
      builder: (context, child) =>
          HandleNotificationInteractions(child: child!),
    );
  }
}

// NOTA: La idea con este widget es para que de chance de establecer el go_router, las configuraciones y todo lo demás para tener todo inicializado cuando
//       click o tap sobre la notificación, adicionalmente así mantenemos separada y aislada la responsabilidad de la aplicación.
class HandleNotificationInteractions extends StatefulWidget {
  final Widget child;

  const HandleNotificationInteractions({super.key, required this.child});

  @override
  State<HandleNotificationInteractions> createState() =>
      _HandleNotificationInteractionsState();
}

class _HandleNotificationInteractionsState
    extends State<HandleNotificationInteractions> {
  // It is assumed that all messages contain a data field with the key 'type'
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    // Lo primero que quiero hacer cuando toque la notificación es almacenarla en el bloc
    context.read<NotificationsBloc>().handleRemoteMessage(message);

    // Procesamos el messageId para quitar los caracteres que no nos interesan
    final messageId =
        message.messageId?.replaceAll(':', '').replaceAll('%', '');

    // Navegamos con mi go_router a la pantalla
    appRouter.push('/push-datails/$messageId');
  }

  @override
  void initState() {
    super.initState();

    // Run code required to handle interacted messages in an async function
    // as initState() must not be async
    setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
