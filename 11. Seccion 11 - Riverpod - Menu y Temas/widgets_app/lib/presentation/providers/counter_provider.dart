// NOTA: Acá vamos a crear nuestro primer provider de riverpod, y ojo que decimos provider
//       pero hace referencia a los de riverpod y no al gestor de estado Provider que usamos
//       anteriormente cuando creamos la aplicación Yes-No App.

// NOTA: Ahora una cosa por la cual a muchas personas les termina gustando Riverpod es porque
//       a la larga se terminan creando muchos pequeños providers que tienen un estado específico
//       que van a ser fáciles de mantener y de probar.

// NOTA: La documentación oficial de Riverpod la encontramos en https://docs-v2.riverpod.dev/docs/introduction/getting_started
//       y en https://riverpod.dev/docs/introduction/getting_started y son dos enlaces es porque uno es la versión a día de hoy
//       que proximamente va a ser reemplazada por la V2 que es la que vamos a usar.

import 'package:flutter_riverpod/flutter_riverpod.dart';

// NOTA: Mentalicemonos que el StateProvider como un proveedor de un estado. Este StateProvider es una pequeña
//       pieza de información de estado de nuestra aplicación, por ejemplo, cual es el tema seleccionado, el
//       valor de una variable numérica, el estado de una clase que queremos mantener y esto lo hace bien poderoso.
//       Este Stateprovider recibe un valor inicial que en este caso es 5
final counterProvider = StateProvider((ref) => 5);
