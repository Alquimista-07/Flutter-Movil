void main() {
  
  // Creamos el mapa.
  // Un mapa básicamente son pares de valores llave - valor
  // Adicionalmente tenemos que tener en cuenta que no tenemos que estar amarrados a que las llaves sean de un tipo
  // en específico, por ejemplo String, sino que también pueden ser enteros, y también no podemos tener un solo tipo
  // sino que podemos tener varios y esto lo convierte en un mapa de objetos similar a un objeto definido en JavaScript
  // o JSON. También no es necesario especificar el tipo del mapa ya que este se va a inferir pero si lo conocemos es 
  // mejor indicarlo
  final Map<String, dynamic> pokemon = {
    'name' : 'Ditto',
    'hp' : 100,
    'isAlive' : true,
    'abilities': <String>['impostor'],
    // Este es otro mapa dentro del mapa inicial
    'sprites' : {
      1 : 'ditto/front.png',
      2 : 'ditto/back.png'
    }
  };
    
  print( pokemon );
  
  // Para usar los mapa hay varias formas, pero la forma más sencilla de usarla es con la notación de llave cuadrada []
  // similar a como se maneja en JS, ya que cuando la llave es string lo colocamos en comillas y cuando es entero lo
  // indicamos sin comillas. Adicionalmente también podemos manejar la notación de punto como en JS pero para poder usarla
  // necesitamos mapear primero ya que si no lo hacemos si damos punto no tenemos acceso a las llaves del mapa y nos tocaría 
  // usar la  notación de llaves cuadradas.
  // OJO. Recordemos que el símbolo $ es para interpolación de Strings
  print( 'Name: ${ pokemon['name'] }' );
  print( 'Sprites: ${ pokemon['sprites'] }' );

  // ------------------------------------------------------------------------------------------------------
  // Tarea: Haciendo referencia a los objetos dentro del mapa sprites. Imprimir el back y front 
  // ------------------------------------------------------------------------------------------------------
  print( 'Back: ${ pokemon['sprites'][2] }' );
  print( 'Front: ${ pokemon['sprites'][1] }' );
  


}