import 'package:flutter/material.dart';
import 'package:widgets_app/config/menu/menu_items.dart';
import 'package:widgets_app/presentation/screens/buttons/buttons_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter + Material 3'),
      ),
      body: _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // NOTA: Con el physics quitamos o colocamos otro comportamiento al scroll
      //physics: const BouncingScrollPhysics(),
      // NOTA: Tomamos las opciones del menu
      itemCount: appMenuItems.length,
      itemBuilder: (context, index) {
        final menuItem = appMenuItems[index];
        return _CustomListTitle(menuItem: menuItem);
      },
    );
  }
}

class _CustomListTitle extends StatelessWidget {
  const _CustomListTitle({
    required this.menuItem,
  });

  final MenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(
        menuItem.icon,
        color: colors.primary,
      ),
      title: Text(menuItem.title),
      subtitle: Text(menuItem.subtitle),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: colors.primary,
      ),
      // NOTA: Evento de la flecha
      onTap: () {
        // NOTA: La documentación oficial de Flutter para la navegación es: https://docs.flutter.dev/ui/navigation
        //       Nuevamente acá vemos que tenemos el context(nuestro arbol de componentes), tenemos el .push para
        //       hacer un push de una nueva página y entendamos el push como que voy a crear un stack de tarjetas.
        //       tengo una tarjeta push coloco sobre esta otra y luego otras y así sucesivamente y luego también
        //       se puede ir haciendo pop, pop, pop e ir quitando pantallas.
        //       Una nota adicional es que también en lugar del push tenemos el método replace para hacer que la
        //       anterior ruta se destruya, es decir, que no voy a poder regresar a la pantalla anterior, pero ese
        //       tema lo trataremos más adelante.
        // NOTA: Esta es una primera forma sencilla de hacer navegación y funciona pero luego como se menciona más
        //       adelante en el comentario de la segunda forma de navegar vamos a cambiar y usar go_router
        /*
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ButtonsScreen(),
          ),
        );
        */

        // NOTA: Esta es una segunda forma de navegar entre pantallas, por la cual a través del MaterialApp que tenemos en el main.dart
        //       podemos definir los routes
        // NOTA: Acá podemos definir las rutas como se haría en web pero esto tiene una limitante, y por lo tanto
        //       aunque podemos hacerlo así existen mejores formas de hacer esto como el go_router, que lo veremos más
        //       adelante, pero de momento esto es para fines ilustrativos.
        Navigator.pushNamed(context, menuItem.link);
      },
    );
  }
}
