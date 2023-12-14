// NOTA: De la misma manera que realizamos con el environment vamos a crearnos nuestro wraper
//       o envoltorio donde vamos a tener los métodos encargados de leer, escribir y borrar nuestros
//       shared_preferences y de esta forma solo usarlo en un único lugar y si al día de mañana algo
//       cambia no afectar toda la aplicación.

// NOTA: Y la razón por la que creo esta clase como abstracta es porque quiero que al día de mañana si se quiere
//       cambiar la implementación, entonces se va a tener que cumplir con esta firma o reglas.
abstract class KeyValueStorageService {
  Future<void> setKeyValue(String key, dynamic value);

  Future getValue(String key, dynamic value);

  Future<bool> removeKey(String key);
}
