void main() {
  
  final String pokemon = 'Ditto'; // Cadenas de texto
  final int hp = 100;             // Número entero (sin decimales)
  final bool isAlive = true;      // Booleano (true/false)
  
  
  // NOTA: Una cosa genial que tiene Dart es que él esta siempre pendiente del null
  //       null safety, es decir, siempre esta pendiente de que valores pueden ser 
  //       nulos o no. Por ejemplo si definimos una variable de la siguiente forma,
  //       esta puede tener tres valores posibles (null, true, false) y al indicar el
  //       simbolo de interrogación (?) le dice a Dart que esta variable puede ser nula.
  //       En los pdf de recursos del curso de la primera sección podemos encontrar más
  //       información sobre esto.
  bool? isAlive2;
  
  final List<String> abilities = ['impostor']; // Forma de definir un listado de String
  final sprites = <String>['ditto/front.png', 'ditto/back.png']; // Otra forma de definir un listado de tipo String
  
  // NOTA: El tipo de dato dynamic es especial, nosotros tenemos que tratar de evitar usar dynamic hasta donde sea posible
  //       pero tampoco tenemos que satanizarlo, es decir, jamás usarlo porque si nos ponemos a tipar a muchísimo nivel, 
  //       especialmente con los mapas puede ser una tarea de nuca acabar y ser un verdadero dolor de cabeza, por lo tanto
  //       hay que encontrar un balance entre donde usar dynamic y donde no. Por ejemplo puede ser que recibamos un mapa de
  //       petición en internet, ahi es donde podemos decir, OK no voy a mapear todo, todo este montón de posibles respuestas
  //       entonces ahí es donde decimos que puede ser dynamic y dynamic significa que puede ser cualquier tipo de dato, y el
  //       dynamic es algo así como un comodin. Adicionalmente debemos sabe que dynamic por defecto es nulo (dynamic == null),
  //       es decir, acepta valores nulos y si tenemos por ejemplo una variable que sea de tipo dynamic Dart va a dar warnings
  //       si las queremos usar y no estamos haciendo algún tipo de evaluación de null safety y tampoco es necesario indicar el 
  //       ? para indicar que puede ser nulo ya que por defecto siempre es nulo.
  //       También al definir la variable como dynamic Dart no va a inferir el tipo por ejemplo en la siguiente variable String
  //       sino que siempre va a decir que es de tipo dynamic y puede ser cualquier tipo de dato, un booleano, una lista, un string
  //       un iterable, una función que regresa un booleadno, un null y por eso hay que tratar de evitarlo ya que basicamente se 
  //       pierde cualquier restricción y puede generar errores ya que por ejemplo podemos tener el valor de la variable en null
  //       y más adelante tener una operación matematica la cual use esa variable lo cual causaría un error en la aplicación pero 
  //       el problema es que Dart no nos avisa que tenemos ese error sino ya que es responsabilidad del desarrollador manejar el 
  //       null safety.
  dynamic errorMessage = 'Hola';
  errorMessage = true;
  errorMessage = [1,2,3,4,5,6];
  
  
  // NOTA: Para hacer stings multilinea solo basta con indicar tres comillas
  //       dobles donde abre y donde cierra.
  print("""
    $pokemon
    $hp
    $abilities
    $sprites
    $errorMessage
  """);
  
}