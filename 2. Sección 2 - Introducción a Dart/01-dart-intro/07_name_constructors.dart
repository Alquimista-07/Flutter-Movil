void main() {
  
  // Creamos una instancia de la clase y le pasamos los valores.
  // Recordemos que el new no es necesario aunque lo podemos especificar, pero si lo especificamos nos va a dar un warning diciendo que no
  // es necesario usarlo.
  final ironman = Hero(
    isAlive: false,
    power: 'Money',
    name: 'Tony Stark'
  );
  
  // Ahora que pasa si nosotros tenemos que crear una instancia de la clase pero lo que recibimos es el valor de una petición HTTP, o una
  // petición web o tenemos que transformar un objeto
  final Map<String, dynamic> rawJson = {
    'name' : 'Tony Stark',
    'power' : 'Money',
    'isAlive' : true
  };
  
  // Entonces teniendo el ejemplo anterior sería lo que nos devuelve la petición y a partir de ese objeto queremos crear la instancia
  // de la clase de la siguiente forma.
  final ironman2 = Hero(
    isAlive : rawJson['isAlive2'] ?? false, // Para evitar el error en caso de que la propiedad no exista y sea nulo, le asignamos un valor por defecto usando ??
    power : 'Money',
    name : 'Tony Stark'
  );
  
  // Pero que tedioso es tener que hacer toda la creación de la instancia de la forma anterior 
  // cuando se tima de una petición HTTP.
  //
  // Por lo tanto sería más facil crear un constructor con nombre el cual reciba el objeto de
  // de la petición en este caso y el cual tenga toda la validación para crear ese objeto.
  // Entonces ya con el constructor por nombre llamado Hero.fromJson y simplemente ya podemos
  // crear la instancia
  final ironman3 = Hero.fromJson( rawJson );
  
  
  
  print( ironman );
  print( ironman2 );
  print( ironman3 );
  
}

class Hero {
    
  String name;
  String power;
  bool isAlive;
  
  Hero({
    required this.name,
    required this.power,
    required this.isAlive
  });
  
  //-------------------------------
  // Constructor por nombre.
  //-------------------------------
  // OJO para ponerlo hay que indicar el punto, adicionalmente lo que necesitamos es:
  // 1. Regresar una instancia de la clase, osea tengo que crear esa instancia
  // 2. También tengo que recibir la cantidad de argumentos que yo deseo.
  //
  // Y luego si podríamos dentro del cuerpo que son las {} hacer el return Hero() con 
  // los valores que necesito, pero lo podemos hacer de la forma corta que es quitar las
  // llaves y poner los dos puntos y definir cada una de las propiedades.
  //
  // Adicionalmente si viene el valor lo asignamos y si no se manda un valor por defecto
  // y tenemos que acostumbrarnos a hacer esta evalución de la posibilidad de null ya que 
  // Dart es key sensitive y podemos cometer errores al recibir un atributo de un JSON 
  // podiendo causar errores en la aplicación.
  Hero.fromJson( Map<String, dynamic> json )
    : name = json['name'] ?? 'No name found', 
      power = json['power'] ?? 'No power found',
      isAlive = json['isAlive'] ?? 'No isAlive found';
  
  @override
  String toString() {
    // Ahora para mostrar el valor de isAlive vamos a usar un operador ternario
    // y si nos damos cuenta es igual que en JS o Java
    return '$name, $power, isAlive: ${ isAlive ? 'Yes!' : 'Nope' }';
  }
    
}