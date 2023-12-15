// NOTA: De la misma manera que realizamos con el environment vamos a crearnos nuestro wraper
//       o envoltorio donde vamos a tener los métodos encargados de leer, escribir y borrar nuestros
//       shared_preferences y de esta forma solo usarlo en un único lugar y si al día de mañana algo
//       cambia no afectar toda la aplicación.

// NOTA: Para grabar el token vamos a usar un paquete llamado shared_prefetences, que es uno de los más usados
//       y es Flutter Favorite. Pero hay que tener en cuenta que este no es el único para este fin, ya que
//       incluso podríamos usar Isar para esta tarea de almacenar de forma local el JWT del usuario.
//       El enalce a la documentación de shared_preferences es el siguiente:
//       https://pub.dev/packages/shared_preferences

// NOTA: Por lo tanto acá vamos a tener nuestra implementación que debe cumplir con la firma que definimos en nuestra
//       clase abstracta

import 'package:shared_preferences/shared_preferences.dart';
import 'key_value_storage_service.dart';

class KeyValueStorageServiceImpl extends KeyValueStorageService {
  // NOTA: Obtenemos la instancia del shared_prefetences
  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

  // NOTA: Implementación del método para obtener el token
  @override
  Future<T?> getValue<T>(String key) async {
    final prefs = await getSharedPrefs();

    // NOTA: Vamos a crear un switch para validar el tipo de dato y de esta forma obtener la llave dependiendo a este
    //       y de esta forma lo hacemos un poco más de uso general y nos serviría para diferentes cosas
    switch (T) {
      case int:
        // NOTA: Acá le decimos que lo tome como un T opcional usando la palabra reservada as
        return prefs.getInt(key) as T?;

      case String:
        // NOTA: Acá le decimos que lo tome como un T opcional usando la palabra reservada as
        return prefs.getString(key) as T?;

      default:
        throw UnimplementedError(
            'Get not implemented for type ${T.runtimeType}');
    }
  }

  // NOTA: Implementación del método para remover el token
  @override
  Future<bool> removeKey(String key) async {
    final prefs = await getSharedPrefs();
    return await prefs.remove(key);
  }

  // NOTA: Implementación del método para establecer o guarfdar el token
  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final prefs = await getSharedPrefs();

    // NOTA: Vamos a crear un switch para validar el tipo de dato y de esta forma establecer el valor dependiendo a este
    //       y de esta forma lo hacemos un poco más de uso general y nos serviría para diferentes cosas
    switch (T) {
      case int:
        // NOTA: Acá el value no lo reconoce como entero a pesar de que debería ser así por lo tanto lo casteamos como entero usando la palabra reservada as
        prefs.setInt(key, value as int);
        break;

      case String:
        // NOTA: Acá el value no lo reconoce como String a pesar de que debería ser así por lo tanto lo casteamos como String usando la palabra reservada as
        prefs.setString(key, value as String);
        break;

      default:
        throw UnimplementedError(
            'Set not implemented for type ${T.runtimeType}');
    }
  }
}
