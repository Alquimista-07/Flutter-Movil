import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/presentation/providers/theme_provider.dart';

class ThemeChangerScreen extends ConsumerWidget {
  static const name = 'theme_changer';

  const ThemeChangerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Escuchamos el provider definido para cambiar el modo
    //final bool isDarkMode = ref.watch(isDarkmodeProvider);

    // NOTA: Ahora como tenemos nuestro ThemeNotifierProvider vamos es a estar escuchando ese
    //       por lo tanto comentamos el anterior
    final isDarkMode = ref.watch(themeNotifierProvider).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Changer'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined),
            onPressed: () {
              // NOTA: De mismo modo ahora como tenemos nuestro ThemeNotifierProvider hacemos el cambio acá
              //ref.read(isDarkmodeProvider.notifier).update((state) => !state);
              ref.read(themeNotifierProvider.notifier).toggleDarkMode();
            },
          )
        ],
      ),
      body: const _ThemeChangerView(),
    );
  }
}

class _ThemeChangerView extends ConsumerWidget {
  const _ThemeChangerView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Escuchamos el provider para cambiar el color del tema.
    // NOTA: OJO yo se que yo no quiero volver a redibujar esto jamás porque los colores nunca van a cambiar ya que son constante y decir que voy a usar el read.
    //       Peeeeeeeeero en la documentación de Riverpod recomienda que inclusive en estos casos usemos es el watch() y Riverpod de todas forma va a saber cuando
    //       va a cambiar y cuando no y también puede que al día de mañana si quramos hacer esto dinámico entonces no es necesario venir a hacer cambios.
    final List<Color> colors = ref.watch(colorListProvider);

    // TAREA: Escuchamos el provider para otener el valor seleccioando en el color
    final int selectedColor = ref.watch(selectedColorProvider);

    return ListView.builder(
      itemCount: colors.length,
      itemBuilder: (context, index) {
        // NOTA: color seleccionado
        final color = colors[index];
        return RadioListTile(
          title: Text('Este Color', style: TextStyle(color: color)),
          subtitle: Text('${color.value}'),
          // NOTA: Con este activeColor el bullet también va a tomar la apariencia del color seleccionado
          activeColor: color,
          // NOTA: Indice seleccioando para basado en la opción que color quiero
          value: index,
          // NOTA: El groupValue es el valor seleccionado y Flutter sabe cual es el valor que nosotros tenemos
          // NOTA: De momento dejamos el group en cero
          groupValue: selectedColor,
          onChanged: (value) {
            // TAREA; Actualizamos el estado para que cambie el bullet.
            ref.read(selectedColorProvider.notifier).state = index;
          },
        );
      },
    );
  }
}
