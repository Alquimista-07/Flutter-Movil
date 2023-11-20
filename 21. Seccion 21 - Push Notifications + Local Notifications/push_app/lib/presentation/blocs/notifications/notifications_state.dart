// NOTA: Para el manejo de nuestras notificaciones vamos a usar FlutterFire que es propio de Firebase Cloud Messaging y que es un servicio ofreciod
//       por google gratuito para el envío de notificaciones en tiempo real. Por lo tanto para esto es necesario instalar el paquete y que va a ser
//       necesario para dicho fin ya que viene con métodos y cosas que vamos a ocupar.
//
//       flutter pub add firebase_messaging
//
//       Adicionalmente la documentación la encontramos en: https://firebase.flutter.dev/docs/messaging/notifications/
//
part of 'notifications_bloc.dart';

class NotificationsState extends Equatable {
  // NOTA:
  final AuthorizationStatus status;

  //TODO: Crear mi modelo de notificaciones
  // NOTA: Este listado es solo para porque queremos mantener las notificaciones, pero realmente no hace falta mantenerlas.
  final List<dynamic> notifications;

  const NotificationsState({
    // NOTA: Puede ser que la aplicación cuando arranque ya tenga los permisos, pero por defecto vamos a manejarlo como no determinado
    //       y luego implementar algún tipo de método o código para determinar el estado de los permisos de autorización para recibir
    //       las notificaciones.
    this.status = AuthorizationStatus.notDetermined,
    this.notifications = const [],
  });

  NotificationsState copyWith({
    AuthorizationStatus? staus,
    List<dynamic>? notifications,
  }) =>
      NotificationsState(
        status: status ?? this.status,
        notifications: notifications ?? this.notifications,
      );

  @override
  List<Object?> get props => [status, notifications];
}
