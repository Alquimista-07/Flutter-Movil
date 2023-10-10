// Podríamos ver una clase abstracta como un molde que va a servir para crear otros moldes y por lo tanto ese molde no sirve para nada más que 
// crear otros moldes.
// Y una clase abstracta no se puede instanciar por si misma y en la vida real el objetivo más usado sería para aplicar diferentes patrones de
// arquitectura o patrones que queramos hacer a lo largo de la aplicación.
void main() {

  // Por lo tanto según lo explicado anteriormente si intentamos instanciarla nos da un error.
  //final windPlant = EnergyPlant();
  
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