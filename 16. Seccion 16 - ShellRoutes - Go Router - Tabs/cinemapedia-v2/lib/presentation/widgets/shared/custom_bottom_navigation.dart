import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
