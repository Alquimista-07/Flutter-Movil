// NOTA: La documentación oficial para el manejo de local notifications lo encontramos en:
//       https://pub.dev/packages/flutter_local_notifications
//
// OJO: si queremos usar las schedule notifications que son notificaciones programadas por tiempo o calendario tenemos que ir a ver el video
//      número 343. LocalNotifications - Android del curso donde explica en que parte de la documentación están las configuraciones que debemos
//      hacer, y lo que tenemos que seguir de dicha documentación para seguirla ya que en el curso este tipo de schedule notifications no se
//      explican y por lo tanto hay que segur los tutoriales de la documentación oficial del paquete de Flutter.

// Solicitud permisos local notifications
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> requestPremissionLocalNotifications() async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
}
