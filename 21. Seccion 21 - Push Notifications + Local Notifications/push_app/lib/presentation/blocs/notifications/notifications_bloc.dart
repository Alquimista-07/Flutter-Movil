// NOTA: Para el manejo de nuestras notificaciones vamos a usar FlutterFire que es propio de Firebase Cloud Messaging y que es un servicio ofreciod
//       por google gratuito para el envío de notificaciones en tiempo real. Por lo tanto para esto es necesario instalar el paquete y que va a ser
//       necesario para dicho fin ya que viene con métodos y cosas que vamos a ocupar.
//
//       flutter pub add firebase_messaging
//
//       Adicionalmente la documentación la encontramos en: https://firebase.flutter.dev/docs/messaging/notifications/
//
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:push_app/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:push_app/domain/entities/push_message.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

// NOTA: Función para recibir notificaciones cuando la aplicación este terminada, es decir, cerrada completamente.
// OJO: Una cosa super importante es que esta función tiene que ser una top level function, es decir, tiene que estar en una jerarquía muy alta en la aplicación.
//      ya que esta requiere ser ejecutada super rápido y como máximo tardar 30 segundos en ser llamada para evitar que sea matado el proceso por el administrador
//      Por lo tanto bien podríamos colocar el método en el main, pero en este caso la vamos a poner acá y hacer el registro del manejador en el main.
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call 'initializeApp' before using other Firebase services.
  await Firebase.initializeApp();

  print('Handling a background message: ${message.messageId}');
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  // NOTA: Esta es el objeto que va a permitir escuchar y emitir mensajería a través de él y el token correspondinte
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationsBloc() : super(const NotificationsState()) {
    // Registro del manejador del evento
    on<NotificationStatusChanged>(_notificationStatusChanged);

    on<NotificationReceived>(_onPushMessageReceived);

    // Verificar estado de las notificaciones
    _initialStatusCheck();

    // Listener para notificaciones en foreground
    _onForegroundMessage();
  }

  // NOTA: Por lo tanto como tenemos un evento para actualziar el estado acorde a los permisos, entonces necesitamos
  //       crear el manejdador de ese evento.
  void _notificationStatusChanged(
      NotificationStatusChanged event, Emitter<NotificationsState> emit) {
    emit(
      state.copyWith(
        status: event.status,
      ),
    );

    // Cuando el estado de la notificación cambia mandamos llamar el método que obtiene el token
    _getFirebaseCloudMessagingToken();
  }

  // Inicialización Firebase
  static Future<void> initializeFirebaseCloudMessagingNotifications() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  // Método para determinar el premiso actual de las notificaciones
  void _initialStatusCheck() async {
    final settings = await messaging.getNotificationSettings();
    add(NotificationStatusChanged(settings.authorizationStatus));
  }

  // Obtener el token del dispositivo
  /*
      test@test.com: [
        token1
        token2
        token3
      ]
    */
  void _getFirebaseCloudMessagingToken() async {
    if (state.status != AuthorizationStatus.authorized) return;

    final token = await messaging.getToken();

    // NOTA: Lo imprimimos por consola pero bien lo podríamos almacenar en el estado o en base de datos del lado del backend
    //       Y mandar notificaciones específicamente al dispositivo con ese token.
    print(token);
  }

  // Escuchar mensajes Push
  // NOTA: Este método es un listener y tenemos que ponerlo para estar escuchando cuando el evento sucede
  void _handleRemoteMessage(RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Messag3e data ${message.data}');

    if (message.notification == null) return;

    print('Message also contained a notification: ${message.notification}');

    final notification = PushMessage(
        //NOTA: Recordemos que el messageId viene algo sucio por lo tanto lo tenemos que ajustar para quitar esos caracteres para evitar romper mi sistema de goRouter
        messageId:
            message.messageId?.replaceAll(':', '').replaceAll('%', '') ?? '',
        title: message.notification!.title ?? '',
        body: message.notification!.body ?? '',
        sentDate: message.sentTime ?? DateTime.now(),
        data: message.data,
        // NOTA: Para la imageUrl esta viene por plataforma, es decir, para iOS, Androi o web es diferente por lo tanto determinamos la plataforma
        imageUrl: Platform.isAndroid
            ? message.notification!.android?.imageUrl
            : message.notification!.apple?.imageUrl);

    print(notification);

    add(NotificationReceived(notification));
  }

  void _onPushMessageReceived(
      NotificationReceived event, Emitter<NotificationsState> emit) {
    emit(state.copyWith(
      notifications: [event.pushMessage, ...state.notifications],
    ));
  }

  void _onForegroundMessage() {
    //NOTA: El método FirebaseMessaging es un Stream y como necesito estar pendiente de él no lo voy a limpiar con el cancel,
    //      pero si necesitaramos hacerlo como se mencionó usariamos el método cancel()
    FirebaseMessaging.onMessage.listen(_handleRemoteMessage);
  }

  // NOTA: Este es el método para manejar el estado de los permisos
  void requestPermission() async {
    // Configuraciones
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    // Llamado del manejador del evento para que se ejecute
    add(NotificationStatusChanged(settings.authorizationStatus));
  }

  // Método para obtener una notificación push si existe o no
  PushMessage? getMessageById(String pushMessageId) {
    final exist = state.notifications
        .any((element) => element.messageId == pushMessageId);

    if (!exist) return null;

    return state.notifications
        .firstWhere((element) => element.messageId == pushMessageId);
  }
}
