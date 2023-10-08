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
  
  // NOTA: Para hacer stings multilinea solo basta con indicar tres comillas
  //       dobles donde abre y donde cierra.
  print("""
    $pokemon
    $hp
    $abilities
    $sprites
  """);
  
}