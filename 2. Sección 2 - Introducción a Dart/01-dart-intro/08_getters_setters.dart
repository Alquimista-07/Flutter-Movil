// NOTA IMPORTANTE: Ojo acá el Dartpad tiene un error ya que aunque la propiedad _side la definimos como privada en la clase
//                  en el método main nos la muestra para poderla usar, pero solo esto es de Dartpad ya en la práctica cuando
//                  estemos codificando en el VS Code con Flutter esto no va a pasar.
void main() {
  
  // Instancia
  final mySquare = Square( side : 10 );
  
  // Ahora con la ayuda del setter vamos a mandar el nuevo valor del side
  // mySquare.side = -5; // Esto nos da error por la validación que tenemos en el setter
  mySquare.side = 5;
  
  
  //print( 'Area: ${ mySquare.calculateArea() }' );
  print ( 'Area: ${ mySquare.area }' );
  
}

class Square {
  
  // Entonces podemos crear una propiedad privada anteponiendo el guión bajo (_)
  // al nombre de la propiedad. Y cuando veamos siempre una propiedad así en Dart 
  // significa que es privada y solo podra ser visible dentro del scope o clase.
  double _side; // side * side // OJO: Esta es una porpiedad privada
  
  // Constructor
  Square( { required double side } )
    : _side = side;
  
  //-------------------------------------------------------------------------------------------------------------
  // Getters y Setters: Como sabemos de otros lenguajes de programación, estos nos sirven para obtener 
  //                    o mandar el valor a una propiedad
  //-------------------------------------------------------------------------------------------------------------
  // Para crear los getters es necesario indicar primero el tipo de retorno que en este caso es double,
  // luego colocar la palabra reservada get para transformarlo en un getter y luego el nombre,  de lo que
  // quiero que sea visto como una propiedad en este caso area.
  double get area {
    return _side * _side;
  }
  
  // Para crear los setters es necesario colocar primero la palabra reservada set y luego el nombre de la 
  // propiedad que queremos colcoar, y por argumento le mandamos el valor que estamos esperando para ser
  // asignado como el nuevo valor
  set side( double value ) {
    // En este caso vamos a imprimir el valor recibido.
    print( 'Setting new value $value' );
    
    // Adicionalmente vamos a hacer una condición que son iguales a otros lenguajes de programación y validar
    // que el valor que ser recibe tiene que ser menor a cero, es decir, un número negativo lance una excepción
    // usando la palabra reservada throw pero adicionalmente estas validaciones tambiéns las podemos hacer con 
    // Aserciones pero este es tema de la siguiente clase.
    
    // También recordemos que al igual que en otros lenguajes de programación si solo tenemos una sola línea de 
    // código podemos omitir el cuerpo de la condición que es con {} y simplemente mandar el resultado
    if( value < 0 ) throw 'Value mus be > 0';
    
    // Si todo sale bien, es decir, no se lanzo la excepción y continuo con la ejecución, ya que sabemos que el throw termina la ejeción
    // hasta ahí, entonces si todo sale bien asignamos el nuevo valor
    _side = value;
    
  }
  
  // Metodo para calcular el área
  double calculateArea() {
    return _side * _side;
  }
  
}