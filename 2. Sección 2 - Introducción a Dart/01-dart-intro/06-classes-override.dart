void main() {
  
  final Hero wolverine = new Hero(name : 'Logan', power : 'Regeneración');
  
  print('Wolverine: $wolverine');
  print( wolverine.toString() );
  print('Wolverine: ${ wolverine.name }');
  print('Wolverine: ${ wolverine.power }');
  
}

class Hero {
    
  String name;
  String power;
  
  Hero( {
    required this.name, 
    this.power = 'Sin poder' 
  } );
  
  // NOTA: Yo puedo sobreescribir el comportamiento de algún método o inclusive propiedades
  //       de mis clases para que en lugar de que haga el comportamiento por defecto haga 
  //       cierto comportamiento especial y adicionalmente Dart nos da un warning diciendonos 
  //       que estamos sobreescribiendo algo y deberíamos indicarlo con la anotación @override.
  //       Por ejemplo vamos a sobreescribir el comportamiento del método toString()
  
  @override
  String toString() {
    return '$name - $power';
  }
    
}