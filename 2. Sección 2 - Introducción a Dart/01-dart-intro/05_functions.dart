// NOTA: Recordemos que podemos revisar los documentos pdf entregados por Fernando los cuales contienen
//       mucha información y ayudas de cosas importantes de Dart y Flutter.
void main() {
  
  // LLamamos las funcione y las imprimimos por consola
  print( greetEveryone() );
  
  print( greetEveryone2() );
  
  print( 'Suma: ${ addTwoNumbers( 10, 20 ) }' );
  
  print( 'Suma usando función flecha: ${ addTwoNumbersFlecha( 50, 40 ) }');
  
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