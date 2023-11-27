// NOTA: La documentación oficial para el manejo de local notifications lo encontramos en:
//       https://pub.dev/packages/flutter_local_notifications
//
// OJO: si queremos usar las schedule notifications que son notificaciones programadas por tiempo o calendario tenemos que ir a ver el video
//      número 343. LocalNotifications - Android del curso donde explica en que parte de la documentación están las configuraciones que debemos
//      hacer, y lo que tenemos que seguir de dicha documentación para seguirla ya que en el curso este tipo de schedule notifications no se
//      explican y por lo tanto hay que segur los tutoriales de la documentación oficial del paquete de Flutter.

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotifications {
  // Solicitud permisos local notifications
  static Future<void> requestPremissionLocalNotifications() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> initializeLocalNotifications() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Inicialización para android
    // NOTA: El defaultIcon es bien bonito porque nosotros lo podemos cambiar basado en el icono de nuestra aplicación.
    //       Y el cual va a ser tomado de la ruta android/app/src/main/res/drawable y adicionalmente solo lo tendríamos
    //       allá y no sería necesario definirlo en los assets del pubspec ya que ese icono hace parte de la app de android
    const initalizationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    // TODO: iOS Configuration

    const initializationSettings = InitializationSettings(
      android: initalizationSettingsAndroid,
      // TODO: iOS configuration settings
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // TODO
      // onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundNotificationResponse
    );
  }
}
