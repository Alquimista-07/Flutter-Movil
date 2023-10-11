// Async - Await
// Bases de la programación asíncrona
// NOTA: La palabra reservada async y await son muy útiles para trabajar en conjunto con los futures, también hay una parte de los streams con los cuales
//       también podemos usar el await, pero sobre los streams se hablara más adelante.

// Acá pasamos también el async al void y técnicamente es como si tuvieramos Future<void> pero al ser void no interesa el retorno por lo tanto no es necesario
// especificar el Future a diferencia de la función httpGer que si nos devuelve algo.
void main () async {
  
  print('Inicio del programa');
  
  // Ahora como sabemos que el Future puede fallar y tenemos que controlar la excepción, entonces en lugar de manejarlo con catchError como teníamos en el ejercicio
  // anterior, acá lo vamos a manejar con un try, catch
  try {
    
    // Como nos damos cuenta acá se resumió mucho más el código al que teníamos en el ejercicio anterior
    // Y con el await básicamente el await transforma los futures que son asíncronos en código síncrono y 
    // secuencial.
    final value = await httpGet('https://urlficticia.com/simulapeticionhttp');
  
    print( value );
    
  } catch (err) {
    print('Error: $err');
  }
  
  print('Fin del programa');
  
}

// La palabra reservada async la vamos a colocar para indicarle que un método o función va a retornar un future
// en pocas palabras cuando colocamos el async vamos a obligar que la función o método regrese un future.
// Por lo tanto tenemos que marcar que la función es un Future y no retornar un primitivo.
Future<String> httpGet( String url ) async {
  
  // Ahora todo el código que teníamos acá en el ejercicio anterior lo podemos resumir con la palabra reservada
  // await, por ejemplo podemos usar el await para que espere a que el Future se realice.
  // Básicamente el await transforma los futures que son asíncronos en código síncrono y secuencial.
  await Future.delayed( const Duration(seconds: 1));
  
  // Al igual que en el ejercicio anterior podemos simular un error no controlado con el throw y comentar el return
  // ya que al pasar por el throw no va a llegar hasta allá.
  throw 'Error en la petición';
    
  // Y cuando se realice la operación que hayamos especificado podemos hacer el retorno del resultado
  //return 'Tenemos un valor de petición http';
  
  // Y si comparamos con el ejemplo anterior es mucho más resumido el código.
  
}