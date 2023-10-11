// NOTA: Para ejemplificar lo que es un future podemos ir al PDF de la hoja de atajos
//       entregada por Fernando en la sección 1 y ahí tenemos la definición de un 
//       future.
//       Un future representa principalmente el acuerdo de una operación asíncrona y
//       ese acuerdo ofrece un resultado, es decir, vamos a obtener un resultado 
//       después de una operación asíncrona que se conoce como future, se puede ver 
//       como una promesa que hay que pronto puede tener un valor.
//       Adicionalmente un future puede fallar y hay que manejar las excepciones.

void main () {
  
  print('Inicio del programa');
  
  // Al llamar la función, Dart sabe que hay trabajo asíncrono y no va a terminar nuestra
  // aplicación hasta que ese trabajo asíncrono se realice.
  // Adicionalmente se dijo antes que un future puede fallar y por lo tanto tenemos que manejar
  // y controlar la excepción, por lo tanto luego del then manejamos el catchError
  httpGet('https://urlficticia.com/simulapeticionhttp').then( (value) {
    print( value );
  }).catchError( (err) {
    print('Error: $err');
  });
  
  print('Fin del programa');
  
}

// Un future se puede generar de varias maneras, hay funciones, hay objetos que crean futures.
// Pero para el ejemplo se va a crear de la siguiente manera simulando una petición http:
Future<String> httpGet( String url ) {
  
  // Colocamos un retraso con duración e 1 segundo, adicionalmente el método Duration puede
  // manejar microsegundos, milisegundos, segundos, minutos, horas, dias para ejecutar esta
  // tarea. Por lo tanto en este caso cuando pase ese segundo va la función que voy a ejecutar.
  // También como sabemos que no va a cambiar lo menejamos como una constante
  return Future.delayed( const Duration(seconds: 1), () {
  
    // Para ver el control de la excepción simulamos un error y comentamos el return
    // ya que debido al throw no va a llegar hasta el return
    throw 'Error en la petición http';
    
    //return 'Respuesta de la petición http';
  
  });
}