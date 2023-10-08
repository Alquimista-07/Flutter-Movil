// NOTA: Los archivos en Dart generalmente los llamamos usando snake case (con guiones bajos para separar nombre) y la extensión es .dart

// La url del compilador en línea de Dart es: https://dartpad.dev/?

// NOTA: Todo programa en Dart empieza por una función llamada main.

//       Nosotros tenemos que tratar de evitar no colocar el tipo deya que por ejemplo si dejamos la función sin un tipo esta va
//       a quedar como dynamic por lo tanto podría regresar cualquier cosa y esto tenemos que evitarlo hasta donde sea posible.
//       Al igual que en otros lenguajes podemos especificar en este caso el void que indica que la función no regresa nada.
//       Adicionalmente a diferencia de JavaScript en Dart el punto y coma es obligatorio.
void main() {
  
  // Creamos una variable sin tipo, el cual va a ser inferido pero de cierto modo es mejor especificar el tipo desde un inicio
  var myName1 = 'Fernando';
  
  // En este caso cuando usamos el final para declarar una variable del mismo modo que el var este va a inferir el tipo de dato.
  // Pero una diferencia es que luego de haberle asignado el valor si luego lo queremos cambiar no se va a poder hacer. 
  final myName2 = 'Fernando';
  
  // Ahora con este late final lo que estamos haciendo es una asignación tardía, que en otras palabras permite decirle a Dart que esa variable
  // tendra un valor al momento de usarse y es reponsabilidad del desarrollador asegurar que eso se cumpla.
  late final myName4 = 'Fernando';
  
  // Otra forma es definirlo como una constante en tiempo de construcción de aplicación a diferencia del late final el cual se crea en tiempo de
  // ejecución, es decir, en momentos diferentes del ciclo de vida de la aplicación. Por lo tanto si tenemos que crear una variable la cual su valor
  // jamás va a cambiar desde el momento que se construye jamas va a cambiar entonces la creamos como constante y esto ayuda a la velodicad de 
  // Dart y Flutter. Pero si en determinado tiempo necesitamos por ejemplo calcular el valor de myName5 entonces usariamos final
  const myName5 = 'Fernando';
  
  // Pero adicionalmente podemos especificar la variable con su tipo directamente y si nos damos cuenta es muy similar a Java
  String myName3 = 'Fernando';
  
  // Imprimimos por consola usando una interpolación de string. Que en JavaScript/ TypeScript lo conocemos como el template String y lo usamos 
  // con ``, acá en Dart hacemos esa interpolación anteponiendole el $ a la variable.
  print('Hola $myName1');
  print('Hola $myName2');
  print('Hola $myName3');
  print('Hola $myName4');
  print('Hola $myName5');
  
  // En caso de que queramos usar por ejemplo un método o propiedad y sumarle la interpolación de Strings tendírmos que encerrar el código en {}
  print('Hola ${ myName5.toUpperCase() }');
  
  // Cualquier expresión que queramos colocar simpre va entre {}
  print('Hola ${ 1 + 1 }');

}