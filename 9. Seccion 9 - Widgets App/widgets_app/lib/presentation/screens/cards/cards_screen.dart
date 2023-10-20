import 'package:flutter/material.dart';

// NOTA: El siguiente enlace nos lleva a la documentación oficial de Material Design 3, en donde contramos ejercicios,
//       ejemplos y demás cosas útiles para implementar de forma rápida.
//       EL enlace es: https://m3.material.io/develop/flutter

const cards = <Map<String, dynamic>>[
  {'elevation': 0.0, 'label': 'Elevarion 0'},
  {'elevation': 1.0, 'label': 'Elevarion 1'},
  {'elevation': 2.0, 'label': 'Elevarion 2'},
  {'elevation': 3.0, 'label': 'Elevarion 3'},
  {'elevation': 4.0, 'label': 'Elevarion 4'},
  {'elevation': 5.0, 'label': 'Elevarion 5'},
];

class CardsScreen extends StatelessWidget {
  // NOTA: Agreamos una propiedad estática constante para asignar el nombre que luego vamos a usar en el go_router
  //       adicionalmente recordemos que usamos el static para evitar crear instancias de la clase para solo tener
  //       acceso a la propiedad
  static const String name = 'cards_screen';

  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cards Screen'),
      ),
      body: const _CardsView(),
    );
  }
}

class _CardsView extends StatelessWidget {
  const _CardsView();

  @override
  Widget build(BuildContext context) {
    // NOTA: Si llegamos a un punto en que tengamos muchas tarjetas creadas las cuales se van a salir de la pantalla esto va a causar un error debido a
    //       que se causa un desbordamiento de los elementos en la pantalla, entonces para corregir o evitar dicho error y agregar un Scroll cuando
    //       se supere la cantidad de elementos agregados a la pantalla que en este caso son las tarjetas, vamos a usar el widget SingleChildScrollView y
    //       este como su nombre lo dice es un único hijo y es un Scroll.
    //       Y esta sería una alternativa a usar el ListView() que es otro widget que usamos anteriormente y cuyo comportamiento es similar.
    return SingleChildScrollView(
      child: Column(
        children: [
          // NOTA: Acá usamos el spred que como sabemos en JS también existe y sirve para lo mismo, y recorremos el map
          //       para asignar las propiedades que definimos en dicho map
          ...cards.map((card) =>
              _CardType1(label: card['label'], elevation: card['elevation'])),
        ],
      ),
    );
  }
}

class _CardType1 extends StatelessWidget {
  final String label;
  final double elevation;

  const _CardType1({required this.label, required this.elevation});

  @override
  Widget build(BuildContext context) {
    // NOTA: Usamos el widget para crear el card
    return Card(
      elevation: elevation,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        child: Column(
          children: [
            // NOTA: El widget Align como su nombre lo indica sirve para alinea o hacer alineación de algún elemento hijo
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.more_vert_outlined),
                onPressed: () {},
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(label),
            )
          ],
        ),
      ),
    );
  }
}
