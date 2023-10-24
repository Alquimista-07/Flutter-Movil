// TAREA: Este nuevo provider va a manejar un booleano llamado isDarkModePorvider

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/theme/app_theme.dart';

final isDarkmodeProvider = StateProvider<bool>((ref) => false);

// Creamos un nuevo provider de Riverpod inmutable que va a contener el listado de colores
// Y el Provider() es el que lo hace inmutable, es decir, que no se puede cambiar, pero en
// todos los lugares donde hagamos uso del ref voy a poder venir a este colorListProvider
final colorListProvider = Provider((ref) => colorList);

// Un simple int
final selectedColorProvider = StateProvider((ref) => 0);
