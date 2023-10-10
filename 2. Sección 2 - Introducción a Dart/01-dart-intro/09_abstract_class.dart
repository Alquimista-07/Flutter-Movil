// Podríamos ver una clase abstracta como un molde que va a servir para crear otros moldes y por lo tanto ese molde no sirve para nada más que 
// crear otros moldes.
// Y una clase abstracta no se puede instanciar por si misma y en la vida real el objetivo más usado sería para aplicar diferentes patrones de
// arquitectura o patrones que queramos hacer a lo largo de la aplicación.
void main() {

  // Por lo tanto según lo explicado anteriormente si intentamos instanciarla nos da un error.
  //final windPlant = EnergyPlant();
  
  // Por lo tanto ya con la clase heredada e implementada podemos proceder a crear la instancia
  final windPlant = WindPlant( initialEnergy: 100 );
  
  print( windPlant );
  
  print( 'Wind: ${ chargePhone( windPlant ) }' );
  
}

// Adicionalmente si tenemos las opciones specíficos, por ejemplo para el atributo tipo podemos crear una enumeración la cual no se le coloca 
// el igual ya que si no sería un Set y adicionalmente algo extraño es que no termina con punto y coma
enum PlantType { nuclear, wind, water }

// Entoces vamos a crea una clase abstracta y para ello usamos la palabra reservada abstract. Pero y para que nos va a servir esto si no la podemos
// instancias, entonces imaginémonos que todas las clases que implementen o extiendan esta clase deberían tener varios tipos, es decir, tener un 
// cierto tipo de molde ya sean atributos o métodos los cales son una clase de firma.
abstract class EnergyPlant {
  
  double energyLeft;
  PlantType type; // Nuclear, Wind, Water que serían los tipos espcíficos definidos con el enumerador
  
  // Constructor
  EnergyPlant({
    required this.energyLeft,
    required this.type
  });
  
  // Adicionalmente hay que tener en cuenta que en una clase abastacta no hacemos la implementación de los métodos ya que esto es un molde y cuando
  // extendamos o implementemos esta clase en las demás ahí si vamos a hacer la implementación
  void consumeEnergy( double amount );
  
}

// Extends o implements
// Extends -> Extender o heredar de otra clase
class WindPlant extends EnergyPlant {
  
  // Adicionalmente nuestro molde o clase de la que estamos heredando nos pide que tenemos
  // que cumplir o satisfacer con la firma que especificamos, la cual es 
  // su constructor, e implementación de sus métodos.
  
  // En este punto necesitamos de alguna manera llamar el constructor del padre
  // y para ello usamos el super() y adicionalmente satisfacemos los 
  // parámetros que nos pide el constructor del padre
  WindPlant({ required double initialEnergy })
    : super( energyLeft: initialEnergy, type: PlantType.wind );
  
  // Implementación del método, el cual se tiene que llamar exáctamente igual
  // y ser del mismo valor de retorno. Adicionalmente se sugiere colocar el
  // @override ya que estamos sobreescribiendo el método
  @override
  void consumeEnergy( double amount ) {
    energyLeft -= amount;
  } 
  
}

// NOTA: La ventaja de crear la clase abstracta es que no necesariamente nos tenemos que apegar a un tipo de planta ya que como se mencionó una
//       clase abstracta es un molde de moldes, por lo tanto el día de mañana podemos crear una nueva planta que implemente o extienda de nuestra
//       clase abstracta la cual va a tener las mismas características y métodos por lo tanto si queremos por ejemplo crear una función para cargar
//       un teléfono al tenerlo de esta forma yo se que cualquier planta que implemente o exitenda de la clase abstracta va a servir para cargar el
//       celular o mejor dicho va a funcionar en la función, y así aplicar varios principios SOLID.
//       Ahora la idea de esta función que creamos es que aplique el principio de inversión de dependencias, esto quiere decir, que yo fácilmente puedo
//       crearme otro tipo de planta de energía y esta función no se va a ver afectada porque todas las plantas de energía saben cuanta energía tienen,
//       adicionalmente todas las plantas tienen los métodos y propiedades que están definidas por la clase abstracta.
double chargePhone( EnergyPlant plant ) {
  if( plant.energyLeft < 10 ) {
    throw Exception('Not enought energy');
  }
  
  return plant.energyLeft - 10;
}