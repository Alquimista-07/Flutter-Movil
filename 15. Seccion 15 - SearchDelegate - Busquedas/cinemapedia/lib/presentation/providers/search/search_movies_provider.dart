// NOTA: Este provider me va a aydar para mantener en memoria el query de búsqueda con el fin de que cuando cerremos
//       el searchDelegate y volvamos a él tengamos lo que buscamos anteriormente
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');
