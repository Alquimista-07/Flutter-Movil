// NOTA: Recordemos que podemos revisar los documentos pdf entregados por Fernando los cuales contienen
//       mucha información y ayudas de cosas importantes de Dart y Flutter.
void main() {
  
  // Listado: Recordemos que este lo reconocemos por tener llaves cuadradas []
  final numbers = [1,2,3,4,5,5,5,6,7,8,9,9,10];
  
  
  print('List original $numbers');
  
  // Como cualquier otro cosa en Dart o como cualquier otro objeto en Dart y las listas no son la excepción tenemos métodos
  // y propiedades
  print('Length: ${ numbers.length }');
  
  // Otra forma de obtener el primer indice y el último sin usar la notación de llaves cuadradas
  print('Primer indice ${ numbers.first }');
  print('Último indice ${ numbers.last }');
  
  // OJO: Si nos damos cuenta acá al imprimir en consola ya no aparece con las llaves cuadradas
  //      sino que aparece dentro de paréntesis indicando que no es un listado sino que es un Iterable.
  //      La forma de identificar el Iterable es porque tiene precisamente esos paréntesis.
  
  //      Básicamente un Iterable es elemento que se puedeiterar que se puede recorrer, es decir,
  //      una colacción de elementos que se puede leer de manera secuencial, y es un objeto que se puede
  //      contar elementos que se encuentran dentro de él, como listas, sets, arreglos, etc.
  //      En pocas palabas es un elemento que sabe cuantos elementos tiene, están ordenados y lo podemos 
  //      utilizar para barrer la información.
  print('Reversed ${ numbers.reversed }');
  
  final reversedNumber = numbers.reversed;
  print('Iterable: $reversedNumber');
  
  // Y con estos Iterables podemos hacer varias cosas geniales.
  // Como por ejemplo recuperar la lista del Iterable y hay que tener en cuenta
  // que una lista no es lo mismo que un Iterable
  print('List: ${ reversedNumber.toList() }');
  
  // Ahora podemos devolver un Set pero es muy diferente a una lista ya que este nos devuelve los valores sin duplicar,
  // es decir, los valores son únicos. Lo podemos reconocer porque lo devuelve con {} y los valores van separados por
  // comas, no son llaves - valor ya que los llave valor va la lleve dos puntos el valor y luego si va la coma, hay que
  // tener muy presente eso en lo que se diferencian.
  print('Set: ${ reversedNumber.toSet() }');
  
  // Un ejemplo mezclando set y list para eliminar duplicados y devolver la lista sería
  print('Valores: ${ numbers.toSet().toList() }');
  
  // Otra cosa geniel es el método where que es un método que tienen los listados que me permite aplicar cierto tipo filtro
  // Por ejemplo mandamos dentro del where un callbak con un parámetro y retornamos los números mayores a 5
  final numbersGreaterThan5 = numbers.where( (int num) {
    return num > 5; // true si es mayor a 5 y false se no son mayores a 5 y filtrar los cuya condición no sea verdadera.
  });
  
  // Y si imprimimos lo que nos devuelve el where es un Iterable
  print( 'Números mayores a 5 (Iterable): $numbersGreaterThan5' );
  
  // Pero lo podemos transformar por ejemplo a un Set de datos o un List
  print( 'Números mayores a 5 (Set): ${ numbersGreaterThan5.toSet() }' );
  
}