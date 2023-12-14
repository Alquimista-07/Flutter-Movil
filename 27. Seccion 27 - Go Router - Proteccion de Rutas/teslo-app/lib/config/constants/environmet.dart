// NOTA:  Documentación Flutter Dotenv para el manejo de las variables de entorno
//        https://pub.dev/packages/flutter_dotenv

// NOTA: Esta es una clase wraper o envoltura al rededor del dotenv y donde solo tenemos la referencia al paquete dotenv
//       y en el caso de que luego quiera cambiar la forma de leer las variables de entorno entonces solo tengo un archivo que
//       modificar y si al día de mañana cambia algo la apliación no se va a afectar.

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  // Método global para cargar el archivo que contiene las variables de entorno
  static initEnvironment() async {
    await dotenv.load(fileName: '.env');
  }

  static String apiUrl =
      dotenv.env['API_URL'] ?? 'No está configurado el API_URL';
}
