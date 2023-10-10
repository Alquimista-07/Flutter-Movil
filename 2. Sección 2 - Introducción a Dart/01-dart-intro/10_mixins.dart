// NOTA: Lectura recomendada sobre los mixins: https://medium.com/flutter-community/dart-what-are-mixins-3a72344011f3
//       Los mixins son algo muy especial de Dart y Flutter ya que son muy utilizados. Fernando menciona que trabaja 
//       bastante con los mixins especialmente porque él creo su propia librería de animaciones, y que vamos a conocer
//       más adelante en el curso y él trabaja bastante con los mixins para hacer ese tipo de animaciones.
//
//       En la url nos mencionan un arbol con unos ejemplos de animales haciendo analogía a los mixins.
//
//       Pero cual sería el beneficio de los mixins y es que nosotros podemos tener clases especializadas que cumplan una 
//       condición en particular, pof ejemplo podríamos mandarle alguna función ó a alguna clase, una clase que implemente
//       específicamente ese mixin o funcionalidad que nosotros queremos, por ejemplo no importa si es un pez, un pájaro o 
//       un mamífero con tal implemente el mixin me va a funcionar.

// El siguiente ejemplo esta basado en el ejemplo explicado en el árbol de jerarquías mostrado en la página del enlace url 
// mencionado al inicio.

// OJO: Cada una de las clases son clases abstractas, por lo tanto no sirven para crear instancias
//      ya que anteriormente se menciono que son moldes para crear moldes.
//      Y recordenos que dentro de cada una pueden ir métodos y atributos propios de cada una pero 
//      sin implementar.

abstract class Animal {}

abstract class Mamifero extends Animal {}

abstract class Ave extends Animal {}

abstract class Pez extends Animal {}

//----------------------------------
// Mixins
//----------------------------------
mixin class Volador {
  // Cualquier animal volador va a tener un método volar
  void volar() => print('Estoy volando');
}

mixin class Caminante {
  // Cualquier animal terrestre va a tener un método caminar
  void caminar() => print('Estoy caminando');
}

mixin class Nadador {
  // Cualquier animal acuático va a tener un método nadar
  void nadar() => print('Estoy nadando');
}

//------------------------------
// Usando los mixins
//------------------------------
// Creamos cada uno de los animales en espcífico y como hacemos esto?
// Con los mixins que podriamos verlos como un nivel de especializaciones que 
// tienen las clases permitiendo dar funcinalidad extra a las clases y en lugar
// de tener que extender un montón de cosas o implementar un montón de cosas 
// podemos darle específicamente esa funcionalidad que nosotros ocupamos.
//
// En el caso del ejemplo serían las especializaciones que tienen cada uno 
// de los animales como volar, nadar, caminar, etc. La idea del mixin es que 
// me permita a mí obviamente crearme una clase por ejemplo el delfín que solo
// nada y es un mamífero.
// Por lo tanto extiende del Mamífero con todas sus propiedades y métodos
// de los mamíferos pero a su vez es un mamífero nadador, entonces puedo 
// usar el mixin con la palabra reservada with y por consecuencia también
// extendería los métodos y propiedes del mixin
class Delfin extends Mamifero with Nadador {}

// Creamos otro animal en este caso el murciélago el cual es un mamífero volador
// y a su vez podría caminar, entonces en este caso le pasamos 2 mixins
// separado por comas.
class Murcielago extends Animal with Volador, Caminante {}

// Creamos otro animal que es el gato, el cual es un mamífero y su especialización
// es caminar
class Gato extends Mamifero with Caminante {}

//----------------------------------------------------------------------------------
// Tarea: Completar los demás animales que se muestran en el árbol de jerarquías.
//        Cada uno con su mixin o especialización
//----------------------------------------------------------------------------------
class Paloma extends Ave with Caminante, Volador {}
class Pato extends Ave with Caminante, Nadador, Volador {}

class Tiburon extends Pez with Nadador {}
class PezVolador with Nadador, Volador {}

void main() {
  
  // Creamos la instancia y usamos los métodos y propiedades tanto de la clase abstacta 
  // principal como del mixin
  final flipper = Delfin();
  flipper.nadar();
  
  final batman = Murcielago();
  batman.caminar();
  batman.volar();
  
  final garfield = Gato();
  garfield.caminar();
  
  final lucas = Pato();
  lucas.caminar();
  lucas.nadar();
  lucas.volar();
  
}