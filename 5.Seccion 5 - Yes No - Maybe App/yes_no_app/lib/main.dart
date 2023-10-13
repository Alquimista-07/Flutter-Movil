// NOTA: El shortcut o snippet para importar material app, crea el main y el widget inicial luego de crear el
//       proyecto es mateapp. Este ya nos autogenera el código base del widget con su appbar, el Scaffold
//      y demás cosas y sobre el cual modificamos para empezar nuestra aplicación.
import 'package:flutter/material.dart';
import 'package:yes_no_app/config/theme/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yes No App',
      // Usamos nuestra instancia de app_theme donde tenemos nuestro tema personalizado
      theme: AppTheme(selectedColor: 3).theme(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Center(
          // Adicionalmente usamos un botón que si nos damos cuenta es un botón distinto al FloatingActionButton que usamos antes
          child: FilledButton.tonal(
              onPressed: () {}, child: const Text('Click me!')),
        ),
      ),
    );
  }
}
