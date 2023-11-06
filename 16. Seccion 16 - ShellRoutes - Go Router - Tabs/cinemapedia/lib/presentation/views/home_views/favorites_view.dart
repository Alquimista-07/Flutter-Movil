// NOTA: Esta va a ser una view pero va a ser parcial la cual va a estar dentro de un widget padre, por lo tanto el concepto de un view o vista
//       no es más que un widget que es muy similar a un widget que sea un screen solo que este es parcial y no ocupa toda la pantalla. Otra cosa
//       es que la vista puede o no tener un scaffold
import 'package:flutter/material.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites View'),
      ),
      body: const Center(
        child: Text('Favoritos'),
      ),
    );
  }
}
