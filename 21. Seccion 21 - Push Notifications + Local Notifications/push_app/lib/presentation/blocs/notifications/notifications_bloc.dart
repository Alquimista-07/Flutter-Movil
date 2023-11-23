// NOTA: Para el manejo de nuestras notificaciones vamos a usar FlutterFire que es propio de Firebase Cloud Messaging y que es un servicio ofreciod
//       por google gratuito para el envío de notificaciones en tiempo real. Por lo tanto para esto es necesario instalar el paquete y que va a ser
//       necesario para dicho fin ya que viene con métodos y cosas que vamos a ocupar.
//
//       flutter pub add firebase_messaging
//
//       Adicionalmente la documentación la encontramos en: https://firebase.flutter.dev/docs/messaging/notifications/
//
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:push_app/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  // NOTA: Esta es el objeto que va a permitir escuchar y emitir mensajería a través de él y el token correspondinte
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationsBloc() : super(const NotificationsState()) {
    // Registro del manejador del evento
    on<NotificationStatusChanged>(_notificationStatusChanged);

    _initialStatusCheck();
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

    // NOTA: NOTA: Lo imprimimos por consola pero bien lo podríamos almacenar en el estado o en base de datos del lado del backend
    print(token);
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
}
