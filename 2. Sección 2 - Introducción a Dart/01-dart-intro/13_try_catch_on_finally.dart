// Try, on, catch y finally
// NOTA: Lo que aprendemos en esta clase va a ser sumamente útil cuando tengamos casos en los cuales tenemos un Future el cual puede fallar
//       por diferentes razones, como por ejemplo en una petición http podría fallar porque no tenemos conexión a internet, porque la respuesta
//       fue mal, porque no se mandaron los argumentos correctos. Pero hay excepciones diferentes y por ejemplo me gustaría decirle al cliente
//       el error de una manera diferente, o si es algo que nosotros mandamos mal y cada uno de los grupos de errores los podríamos agrupar y 
//       manejarlos de manera similar o de manera independiente.
void main () async {
  
  print('Inicio del programa');
  
  // Try: Intenta hacer esto
  try {
    // Si todo salio bien!, ejecuta esto. 
    final value = await httpGet('https://urlficticia.com/simulapeticionhttp');
  
    print( 'Éxito: $value' );
    
  }
  
  // Acá viene un paso genial que es usando la palabra reservada on.
  //
  //on: Este me permite a mí reaccionar basado en el tipo de exception que recibamos.
  //
  //    Recordemos que en la función httpGet estoy simulando y lanzando una excepción del tipo Exception
  //    y como cayó acá en el on la manejamos y por consecuencia no llega o entro en el catch.
  //
  //    Ahora para entrar en el catch tedríamos que tener una excepción no controlada o que no estamos controlando
  //    como teníamos anteriormente solo con el throw 'Error en la petición' el cual podemos descomentar y
  //    comentar el throw Exception para ver que ahora si entra en el catch.
  //
  //    Adicionalmente si queremos obtener el mensaje en el on podemos agregar el catch(err) e imprimirlo
  //    pero si no simplemente lo omitimos o lo quitamos y solo dejamos el on Exception { }.
  //    Pero la ventaja de tener el mensaje de la exepción es que nosotros podemos crear nuestras clases
  //    personalizadas y poder tener un mensaje específico o algún tipo de pripiedad que me ayude a mi a poder
  //    mostralo al usuario en pantalla para que sepan que algo salio mal.
  //
  //    También hay que tener en cuenta que el parámetro del catch lo podemos llamar como queramos y no 
  //    necesariamente se tiene que llamar err.
  on Exception catch(err) {
    print('Tenemos una Exception: $err');
  }
  
  // catch: Si ocurro algo mal haz esto
  catch (err) {
    print('Oops!!! algo terrible paso: $err');
  }
  
  // finally: Con este podríamos verlo como que no importa si hizo el try o el catch siempre3
  //          vas a ejecutar esto.
  finally {
    print( 'Fin del try y catch' );
  }
  
  print('Fin del programa');
  
}

Future<String> httpGet( String url ) async {
  
  await Future.delayed( const Duration(seconds: 1));
  
  // Al igual que en el ejercicio anterior podemos simular un error no controlado con el throw y comentar el return
  // ya que al pasar por el throw no va a llegar hasta allá.
  //throw 'Error en la petición';
  
  // Ahora si lancemos una excpción en particular.
  // OJO: Recordemos que por ejemplo en JAVA usamos la palabra reservada new (throw new Excpetion) pero recordemos que 
  //      en Dart no es necesario ya que lo marca como un warning, por lo tanto lo omitimos.
  throw Exception( 'No hay parámetros en el URL' );
  
  //return 'Tenemos un valor de petición http';
  
}