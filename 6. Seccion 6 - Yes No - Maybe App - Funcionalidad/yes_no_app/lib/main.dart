// NOTA: El shortcut o snippet para importar material app, crea el main y el widget inicial luego de crear el
//       proyecto es mateapp. Este ya nos autogenera el código base del widget con su appbar, el Scaffold
//      y demás cosas y sobre el cual modificamos para empezar nuestra aplicación.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/config/theme/app_theme.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/screens/chat/chat_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // NOTA: Agregamos el provider
    return MultiProvider(
      providers: [
        // NOTA: Este ChangeNotifier Provider espera que le pasemos una propiedad o método llamada create la cual espera que yo haga la creación
        //       de la instancia inicial. Ahora porque le colocamos como guion bajo (_) a el parámetro, es porque ahí va el BuildContext pero si
        //       no lo vamos a usar no podemos dejar el parámetro vacío, es decir, solo los paréntesis ya que necesitamos especificarlo pero pues
        //       en este caso como no vamos a usarlo por eso lo indicamos solo con el guion bajo (_) y esto es bien común para indicar que no me
        //       interesa ese argumento y ya con esto creamnos nuesto ChatProvider a nivel global de la aplicación, y es como si hubiera envuelto
        //       toda mi aplicación y todos los widgets hijos va a tener acceso y poder consultar la información del provider.
        // NOTA: Ya con esto se preseta para que ya en la parte superior donde aparece la barra del debug cuando ejecutamos la aplicación tengamos
        //       un ícono similar a una lupa con el logo de Flutter que si lo presionamos nos va a abrir las DevTools y al cargar nos va a mostrar
        //       el árbol de widgets completom, similar a las DevTools de React que nos muesta el API Context
        ChangeNotifierProvider(create: (_) => ChatProvider())
      ],
      child: MaterialApp(
        title: 'Yes No App',
        // Usamos nuestra instancia de app_theme donde tenemos nuestro tema personalizado
        theme: AppTheme(selectedColor: 3).theme(),
        debugShowCheckedModeBanner: false,
        home: const ChatScreen(),
      ),
    );
  }
}
