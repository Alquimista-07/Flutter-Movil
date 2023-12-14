// NOTA: De la misma manera que realizamos con el environment vamos a crearnos nuestro wraper
//       o envoltorio donde vamos a tener los métodos encargados de leer, escribir y borrar nuestros
//       shared_preferences y de esta forma solo usarlo en un único lugar y si al día de mañana algo
//       cambia no afectar toda la aplicación.

// NOTA: Para grabar el token vamos a usar un paquete llamado shared_prefetences, que es uno de los más usados
//       y es Flutter Favorite. Pero hay que tener en cuenta que este no es el único para este fin, ya que
//       incluso podríamos usar Isar para esta tarea de almacenar de forma local el JWT del usuario.
//       El enalce a la documentación de shared_preferences es el siguiente:
//       https://pub.dev/packages/shared_preferences

// NOTA: Y la razón por la que creo esta clase como abstracta es porque quiero que al día de mañana si se quiere
//       cambiar la implementación, entonces se va a tener que cumplir con esta firma o reglas.
abstract class KeyValueStorageService {
  // NOTA: Recordemos que el T es un tipo genérico por lo tanto puede recibir cualquier tipo de dato, por ejemplo si le mando un entero le va a decir que lo
  //       maneje como un entero, o si le mando un string lo maneje como un string y así sucesivamente y de esta forma poder saber que tipo de dato es ese.
  //       Y esto lo hacemos con la finalidad de no mandarlo como dynamic y evitar posibles problemas gracias al null safety.
  Future<void> setKeyValue<T>(String key, T value);

  Future<T?> getValue<T>(String key);

  Future<bool> removeKey(String key);
}
