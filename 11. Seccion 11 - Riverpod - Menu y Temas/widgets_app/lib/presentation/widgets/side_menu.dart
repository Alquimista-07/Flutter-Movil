import 'dart:io';

import 'package:flutter/material.dart';
import 'package:widgets_app/config/menu/menu_items.dart';

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
    // NOTA: Para determinar si el dispositivo tiene notch vamos a apoyarnos en el viewPadding el cual cual por
    //       ejemplo nos ayuda a saber cuando padding se tiene en el top, y si es mayor a 35 entonces tenemos un
    //       notch
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;

    // NOTA: El siguiente código de ejemplo nos ayuda a determinar la plataforma en la cual estamos ejecutando la app
    /*
    if (Platform.isAndroid) {
      print('Android $hasNotch');
    } else {
      print('IOs $hasNotch');
    }*/

    return NavigationDrawer(
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {
        // NOTA: Nuevo indice que queremos seleccionar para que se vea reflejado en el menu y aparezca seleccionado
        setState(() {
          navDrawerIndex = value;
        });
      },
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(28, hasNotch ? 0 : 5, 16, 10),
          child: const Text('Main'),
        ),

        // NOTA: Usamos el spred de los menuItems. Adicionalmente vamos a usar el sublist con el parámenteo 0,3 el cual básicamente
        //       lo que hace es que tengamos solo los 3 primeros elementos del listado de menuItems
        ...appMenuItems.sublist(0, 3).map(
              (item) => NavigationDrawerDestination(
                icon: Icon(item.icon),
                label: Text(item.title),
              ),
            ),
        // NOTA: Luego de tener ese sublistado de tres elementos, vamos a crear una barra divisoria
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(), // NOTA: Este widget crea la línea divisoria.
        ),

        // NOTA: Continuamos construyendo las demás opciones del menú
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
          child: Text('More Options'),
        ),
        // Tomamos las opciones de la 3 en adelante
        ...appMenuItems.sublist(3).map(
              (item) => NavigationDrawerDestination(
                icon: Icon(item.icon),
                label: Text(item.title),
              ),
            ),
      ],
    );
  }
}
