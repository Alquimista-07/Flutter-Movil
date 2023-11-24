part of 'notifications_bloc.dart';

abstract class NotificationsEvent {
  const NotificationsEvent();
}

// NOTA: Para actualizar el estado acorde a los permisos, necesitamos crear un evento
class NotificationStatusChanged extends NotificationsEvent {
  final AuthorizationStatus status;

  NotificationStatusChanged(this.status);
}

// TODO 2: NotificationReceived #PushMessage
