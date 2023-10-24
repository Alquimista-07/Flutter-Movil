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

// Un objeto de tipo AppTheme (Custom)
// NOTA: Ahora tenemos que pasarle el como primver valor la clase que se va a encargar de controlar nuestro estado (ThemeNotifier)
//       y como segundo valor es el estado interno (AppTheme) y retornarmos la primera intancia de ThemeNotifier que es el que
//       inicializa el tema y perfectamente podemos mandar si queremos la semilla de colores, cual es el que estaba seleccionado en
//       el storage, y cualquier tipo de información que queramos mandar cuando se cree la primera instancia de ThemeNotifier
final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, AppTheme>((ref) => ThemeNotifier());
// NOTA: Si ocuparamos podríamos pasar el ref como argumento para tener la referencia a todo el estado global de la aplicación y usarlo
//       en el ThemeNotifier

// Controller o Notifier
// Este StateNotifier se va a encargar de mantener un estado en particular en este caso mantener una instancia de mi AppTheme
class ThemeNotifier extends StateNotifier<AppTheme> {
  // NOTA: Esto es básicamente decirle necesito que crees la instancia de mi AppTheme con sus valores por defecto.
  //       STATE = Estado = new AppTheme();
  ThemeNotifier() : super(AppTheme());

  // NOTA: Ahora este va a ser el nuevo método que vamos a usar para cambiar el icono de claro u obscuro
  void toggleDarkMode() {
    state = state.copyWith(isDarkmode: !state.isDarkMode);
  }
}
