import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigation({super.key, required this.currentIndex});

  void onItemTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home/0');
        break;

      case 1:
        context.go('/home/1');
        break;

      case 2:
        context.go('/home/2');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (value) => onItemTap(context, value),
      // NOTA: Adicionalmente como no queremos que se note la línea de elevación y se marque y de la impresión de
      //       una linea divisoria entonces la podemos quitar con la propiedad elevation
      elevation: 0,
      // NOTA: OJO para que funcione bien ocupamos al menos dos hijos
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.thumbs_up_down_outlined),
          label: 'Populares',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Favoritos',
        )
      ],
    );
  }
}
