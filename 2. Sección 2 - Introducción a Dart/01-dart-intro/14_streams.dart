// NOTA: La verdad es que hay mucho relacionado a los futures y streams y la programación asíncrona,
//       nosotros podemos ver un poco más en detalle en el pdf que nos paso Fernando en la sección 1
//       y cuando lleguemos al punto de usarlo Fernando va a hacer referencia a el en el curso de 
//       Flutter propiamente y por ahora solo es una introdución.
//       Pero ¿Qué son los streamos? Los streams pueden ser retornados y usados como objetos, funciones o
//       métodos, es decir, los streamos pueden venier de muchos lugares en pocas palabras. Los streams son
//       flujos de información que pueden estar emitiendo valores peridicamente, una única vez o nunca.
//       Podríamos ver este como cuando estamos viendo alguna película o un video, entonces la barra de progreso
//       de carga del video que tenemos ahí sería la totalidad de nuestro stream, y cada uno de los cuadros que
//       vamos viendo en el video es básicamente una emisión del stream y esto es básicamente un concepto rápido 
//       de lo que son los streams.
//       Otro ejemplo podríamos tomar que los streams son como el flujo de agua de una manguera y todo esa corriente
//       de agua es el stream y luego nosotros podemos cerrar la maguera, volverla a abrir, evitar que se cierre, en
//       general, es decir, podemos hacer lo que queramos con ese flujo de agua.

// NOTA ADICIONAL: En FLutter vamos a usar muchísmos streams y es muy poderoso el uso de los mismos.

// --------------------------------
// Ejemplo
// --------------------------------
// Creamos una función que va a ser un stream sencilla.
// Y esto ya viene en Dart el cual ya nos ofrece muchas formas de crear streams automáticos.
// Adicionalmente tenemos que especificar que esta función va a regresar un Stream y adicionalmente se
// se que este stream debería estar emitiendo valores de algún tipo, es dceir, yo tengo que indicar que
// tipo de información fluye a través de ese strem, en este caso del ejemplo son números enteros (int)
Stream<int> emitNumbers () {
  
  // Usamos la palabra reservada Strema que básicamente es un objeto y vamos a usar un constructor
  // de streams llamado periodic, pero si nos fijamos al colocar el punto nos muestran varios como
  // el fromFuture, el fromIterable. etc.
  // El periodic va a iniciar a emitir valores de 0, 1, 2, 3, 4, 5, ... hasta que este stream se cierre
  // por decirlo así. 
  // En este caso mandamos una duración que especificamos en 1 segundo y luego especificamos que es lo que
  // va a suceder luego de que el segundo pase, en este caso una función
  return Stream.periodic( const Duration( seconds: 1 ), ( value ) {
    print('Desde periodic: $value');
    return value;
  })
  // Ahora yo solo quiero que se emitan solo 5 valores y para ello usamos el take, similar a como se hace en RxJS
  .take(5);
  
}

void main () {
  
  // Ahora para que los streams sirvan o empiecen a emitir valores alguien los tiene que estar escuchando, y si nos damos cuenta
  // es parecido a los observables en RxJS a los cuales nos tenemos que suscribir para poderlos llamar.
  // Un ejemplo sería que nosotros estemos en un auditorio esperando y a punto de dar una charla pero si no llega nadie al auditorio
  // entonces para que vamos a dar la charla.
  // Entoncces para escuchar las emisiones del stream usamos el listen
  emitNumbers().listen( (val) {
    print('Stream value: $val');
  });
  
  // Adicionalmente este va a segur emitiendo valores hasta que se cancele la escucha, similar al cencepto como lo
  // haríamos en RxJS al hacer el unsubscribe del observable. Pero en Dart y Flutter usamos es el .close() el cual
  // se encarga de realizar esta tarea de cancelar o desuscribir el stream.
  
}