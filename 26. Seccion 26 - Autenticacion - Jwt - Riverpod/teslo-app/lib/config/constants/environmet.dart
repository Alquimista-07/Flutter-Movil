// NOTA:  Documentación Flutter Dotenv para el manejo de las variables de entorno
//        https://pub.dev/packages/flutter_dotenv

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  // Método global para cargar el archivo que contiene las variables de entorno
  static initEnvironment() async {
    await dotenv.load(fileName: '.env');
  }

  static String apiUrl =
      dotenv.env['API_URL'] ?? 'No está configurado el API_URL';
}
