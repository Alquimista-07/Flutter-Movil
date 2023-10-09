// NOTA: Hay un concepto que es indispensable en Flutter y ojo que se dice Flutter no Dart
//       y es que nosotros manejemos las clases en Dart ya que más o menos el 95%> en Flutter,
//       son puras clases.
void main() {
  
  // Tenemos dos formas de crear la instancia, una es anteponiendo el new y la 
  // otra es sin anteponerlo, aunque básicamente nos va a indicar que usar el
  // new ahora es innecesario.
  
  // Creamos instancias de la clase usando las 2 formas.
  // Y en una especificamos el tipo que sería Hero, y en la otra no y por defecto lo va a inferir
  // pero pues no esta de más especificarlo.
  final Hero wolverine = new Hero('Logan', 'Regeneración');
  final spiderman = Hero('Peter', 'Sentido arácnido');
  
  print('Wolverine: $wolverine');
  print('Wolverine: ${ wolverine.name }');
  print('Wolverine: ${ wolverine.power }');
  
  print('Spiderman: $spiderman');
  print('Spiderman: ${ spiderman.name }');
  print('Spiderman: ${ spiderman.power }');
  
  
}

// Recordemos que la analogía de una clase es que es como un molde para hacer galletas y con dicho
// molde podemos crear tantas galletas como queramos.
// Recordando que en la programación orientada a objetos por decirlo así es la representación de algo 
// que existe en la vida real, por ejemplo si tenemos un celular, el celular sería la clase, y los 
// celulares tienen X cantidad de cámaras, memoria ram, almacenamiento etc que serían los atributos
// y métodos dentro de la clase.
class Hero {
    
  // ATRIBUTOS.
  // Ahora igual que se ha mencionando antes, Dart es bien minucioso con el null safety por lo tanto si tenemos
  // atributos que pueden ser nulos nos va a dar alertas y errores, por lo tanto debemos tener cuidado con ello
  // e inicializar. Adicional a esto tambiém de la misma manera podemos indicar que son opcionales con el signo ?
  // (Un ejemplo para colocarla opcional es: String? name)pero hay que tener en cuenta que es responsabilidad del 
  // desarrollador inicializarlas antes de ser usadas.
  String name;
  String power;
  
  // NOTA: Entonces para inicializar las variables lo podemos hacer a través del constructor, y como sabemos en otros leguajes de programación
  //       como Java o JavaSctipt/TypeScript, el constructor no es más que la función inicial y la primera que se va a llamar cuando
  //       inicializamos o creamos la instancia de la clase.
  
  // NOTA: OJO Tenemos dos formas de definir el constructor de una clase y para los cuales unas veces nos va a venir bien
  //       hacerlo de una forma y otras de la otra forma según sea el caso.
  
  // MÉTODO CONSTRUCTOR: Primera forma de crearlo.
  // NOTA: Adicionalmente recordando que en otros lenguajes de programación anteponemos la palabra this para hacer referencia al atributo, en Dart este es 
  //       opcional y de hecho nos va a dar un warning indicando que es innecesario colocarla ya que él sabe a que estamos haciendo 
  //       referencia. Podemos revisar la hoja de atajos de Dart para más información entregada por Fernando en la sección 1.
  //       this.name = pName;
  Hero( String pName, String pPower )
    : name = pName,
      power = pPower;
  
  // MÉTODO CONSTRUCTOR: Segunda forma de crearlo
  // Hero( this.name, this.power );
    
}