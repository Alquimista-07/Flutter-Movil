// NOTA: En el siguiente enlace podemos encontrar un ejemplo de como sería la nueva forma para mantener el keepalive
//       usando stateful shell route.
//       https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    // NOTA: Con esta función vamos a obtener el path en el que estamnos actualemten y de esta forma
    //       mostrar resaltando con color el ícono del tab sobre el que estamos
    int getCurrentIndex(BuildContext context) {
      final String location = GoRouterState.of(context).fullPath ?? '/';

      switch (location) {
        //* Home
        case '/':
          return 0;

        //* Categorias
        case '/categories':
          return 1;

        //* Favoritos
        case '/favorites':
          return 2;

        //* Si la ruta no existe
        default:
          return 0;
      }
    }

    // Método para navegar entre los tabas
    void onItemTap(BuildContext context, int index) {
      switch (index) {
        //* Home
        case 0:
          context.go('/');
          break;

        //* Categories
        case 1:
          context.go('/categories');
          break;

        //* Favorites
        case 2:
          context.go('/favorites');
          break;
      }
    }

    return BottomNavigationBar(
      // NOTA: Adicionalmente como no queremos que se note la línea de elevación y se marque y de la impresión de
      //       una linea divisoria entonces la podemos quitar con la propiedad elevation
      elevation: 0,
      // NOTA: Ahora vamos a pasarle nuetra función que nos permite obtener sobre que índice nos encontramos
      currentIndex: getCurrentIndex(context),
      // NOTA: Ahora para el tema de la navegación entre view tenemos el método onTap que recibe una función donde
      //       el value es la posición índice seleccionada, por lo tanto basado en esa posición índice es a donde
      //       queremos navegar por lo tanto nos podríamos crear un método para hacer esto. En este caso el método
      //       lo voy a llamar onItemTap
      onTap: (value) => onItemTap(context, value),
      // NOTA: OJO para que funcione bien ocupamos al menos dos hijos
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.label_outlined),
          label: 'Categorías',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Favoritos',
        )
      ],
    );
  }
}
