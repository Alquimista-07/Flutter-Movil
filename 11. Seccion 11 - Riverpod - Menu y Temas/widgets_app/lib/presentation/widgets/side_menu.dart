import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  // NOTA: Propiedad para obtener la opción seleccionada
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {
        // Nuevo indice que queremos seleccionar
        setState(() {
          navDrawerIndex = value;
        });
      },
      children: [
        NavigationDrawerDestination(
          icon: const Icon(Icons.add),
          label: const Text('Home Screen'),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.add_shopping_cart_rounded),
          label: const Text('Otra Pantalla'),
        ),
      ],
    );
  }
}
