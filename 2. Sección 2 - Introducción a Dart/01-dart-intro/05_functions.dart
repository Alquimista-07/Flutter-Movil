// NOTA: Recordemos que podemos revisar los documentos pdf entregados por Fernando los cuales contienen
//       mucha información y ayudas de cosas importantes de Dart y Flutter.
void main() {
  
  // LLamamos las funcione y las imprimimos por consola
  print( greetEveryone() );
  
  print( greetEveryone2() );
  
  print( 'Suma: ${ addTwoNumbers( 10, 20 ) }' );
  
  print( 'Suma usando función flecha: ${ addTwoNumbersFlecha( 50, 40 ) }');
  
  //---------------------------------------
  // Parámetros: Posicionales y por nombre
  //---------------------------------------
  print( addTwoNumbersOptional3( 20 ) );

  // Como nos damos cuenta acá ya estamos llamando la función y pasando los valores de los argumentos por nombre 
  // y esta forma de pasar parámetros se usa muchísimo en Flutter.
  print( greetPerson( message: 'Hi', name: 'Fernando' ) );


}

// Función sencilla que regresa un String 
// Adicionalmente recordemos especificar el tipo de la función
String greetEveryone() {
  return 'Hello everyone!';
}

// Dart también tiene las lambda functions o funciones de flecha y se usan
// igual a como lo conocemos en otros lenguajes de programación como JS/TS.
// OJO. Con una gran diferencia es que si colocamos la flecha luego no podemos
//      dar un curpo a la función con {} como lo haríamos en JS/TS sino que
//      inmediatamente tenemos que colocar el valor de retorno o si no nos va a
//      dar error y para evitarlo tendríamos que usar la función tradicional.
String greetEveryone2() => 'Hello everyone 2';

// Función que recibe parámetros. A pesar de que a los parámetros ni la función es
// necesario especificar el tipo debemos acostumbrarnos a hacerlo ya que si no los
// especificamos esto es muy volátil ya que si nos damos cuanta si no le especificamos
// el tipo a los parámetros nos va a decir que son dynamic a pesar de que el retorno 
// lo estemos especificando como un entero y al ser dinamic podríamos mandar cualquier 
// cosa generando complicaciones al depurar. Por lo tanto es mejor tener un tipado estrícto
int addTwoNumbers( int a, int b ) {
  return a + b;
}

//-----------------------------------------------------------------------------
// Tarea: Convertir la función addTwoNumbers en una función de flecha
//-----------------------------------------------------------------------------
int addTwoNumbersFlecha( int a, int b) => a + b;

// Adiconalmente que pasa si queremos que unos o varios de los parámetros de la función
// sean opcionales para ello indicamos los argumentos dentro de llaves cuadradas.
// y adicionalmente colocamos el ?
int addTwoNumbersOptional( int a, [ int? b ] ){
  
  // Ahora esto nos va a marcar un error ya que b puede potencialmente ser nulo. Para ello
  // podemos manejarlo de varias forma, una de ellas sería preguntar si b tiene un valor lo 
  // asigne y que si no coloque cero.
  b = b ?? 0; // Si es null coloca cero
  
  // Una forma resumida de hacer exáctamenteo lo mismo que lo anterior es:
  //b ??= 0;
  
  return a + b;
}

// Ahora si no quisieramos usar la notación con signo de interrogación
// y luego manejar internamente que si es null asigne cero, también lo
// podemos hacer directamente similar a como se haría con JS. Si nos
// damos cuenta en el parámentro imitimos el ? y le damos el valor por
// por defecto cero con el =
int addTwoNumbersOptional2(int a, [int b = 0]) {
  return a + b;
}

//--------------------------------------------------
// Parámetros: Posicionales y por nombre
//--------------------------------------------------

// En este caso tenemos una función con dos parámetros, que uno es obligatorio 
// y el otro no, adicionalmente al definirlos de esta forma sean obligatorios o
// no los estamos definiendo como parámetros posicionales, es decir que siempre el
// primer parámetro se va a llamar a, el segundo b y así sucesivamente como lo hacemos
// tradicionalmente en otros lenguajes de programación y así trabaja.
int addTwoNumbersOptional3( int a, [ int b = 0 ] ){
  return a + b;
}

// Pero Dart adicionalmente nos ofrece una forma especial de ponerle nombres a nuestros
// parámetros para que cuando nosotros estemos llamando la función y mandemos esos argumntos
// entonces yo poder especificar inclusive el orden o ponerlo en cualquier posición como es
// o asegurarme que va a recibir el valor a el parámetro que yo estoy esperando.
// Para hacer eso los encerramos en llaves {} lo cual los convierte en opcionales y por nombre
// como tenemos en el siguiente ejemplo en el cual el name es opcional y lo especificamos con ?
// y ojo sabemos que al ser opcional puede ser nulo adicionalmente también podemos obligar anteponiendo
// required y eso hace que siempre tiene que ser enviado, adicionalmente también tenemos el 
// parámetro message que le asignamos un valor por defecto en caso que sea nulo
String greetPerson( { required String name, String message = 'Hola, ' } ) {
  return '$message $name';
}