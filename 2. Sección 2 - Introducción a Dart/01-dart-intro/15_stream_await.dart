//--------------------------------
// async* y await
//--------------------------------
// Este es un tema bastante interesante ya que a como vimos anteriormente el async retornaba un Future pero lo interesante es que
// el async* va a retornar un Stream, y básicamente el async* es una función o un método que regresa un Stream
void main() {
  
  emitNumbers().listen( (int value) {
     print( 'Strean value: $value' );
  });
  
}

// Adicionalmente podemos ser bien específicos con el tipo de dato e indicarselo al Stream y también cuando llamemos la función
// podemos indicar el tipo de dato al value o valor cuando llamemos el listen del Stream
Stream<int> emitNumbers() async* {
  
  // Creamos una serie de emisiones controladas
  final valuesToEmit = [1,2,3,4,5];
  
  
  // Creamos un ciclo, también tenemos los forEach, for tradicionales y son muy similares a como se usan en Java o JavaScript
  // para ver más información podemos buscar en la documentación oficial https://dart.dev/
  for( int i in valuesToEmit ) {
    await Future.delayed( const Duration(seconds: 1));
    // El yield es como ceder un valor ahora, como ten este valor ahora y luego ten este valor ahora y ten
    // este otro valo ahora y así sucesivamente. Pero esto es algo que aún no vamos a entrar muy en detalle
    // ya que es algo que vamos a ver cuando estemos trabajando propiamente en Flutter y ocupemos los async*
    // para hacer emisiones controladas o algo técnicamente relacionado al UI.
    yield i;
  }
  
}