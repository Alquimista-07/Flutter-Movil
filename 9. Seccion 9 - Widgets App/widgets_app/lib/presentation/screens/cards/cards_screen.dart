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

          ...cards.map((card) =>
              _CardType2(label: card['label'], elevation: card['elevation'])),

          ...cards.map((card) =>
              _CardType3(label: card['label'], elevation: card['elevation'])),

          ...cards.map((card) =>
              _CardType4(label: card['label'], elevation: card['elevation'])),

          const SizedBox(height: 40),
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

class _CardType2 extends StatelessWidget {
  final String label;
  final double elevation;

  const _CardType2({required this.label, required this.elevation});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // NOTA: Usamos el widget para crear el card
    return Card(
      // NOTA: La propiedad shape es básicamente la forma
      shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          side: BorderSide(color: colors.outline)),
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
              child: Text('$label - outline'),
            )
          ],
        ),
      ),
    );
  }
}

class _CardType3 extends StatelessWidget {
  final String label;
  final double elevation;

  const _CardType3({required this.label, required this.elevation});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // NOTA: Usamos el widget para crear el card
    return Card(
      color: colors.surfaceVariant,
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
              child: Text('$label - Filled'),
            )
          ],
        ),
      ),
    );
  }
}

class _CardType4 extends StatelessWidget {
  final String label;
  final double elevation;

  const _CardType4({required this.label, required this.elevation});

  @override
  Widget build(BuildContext context) {
    // NOTA: Usamos el widget para crear el card
    return Card(
      // NOTA: Ahora como estamos usando una imágen vamos a perder los bordes redondeados de la tarjeta
      //       entonces esto usamos la propiedad clipBehavior a la cual le asignamos el Clip.hardEdge
      //       cuya función es evitar que los hijos se salgan de su contenedor padre.
      clipBehavior: Clip.hardEdge,
      elevation: elevation,
      // NOTA: A diferencia de los otros card a este le removemos el Padding, y para removerlo de forma fácil y rápida sin afectar
      //       los hijos, simplemente nos paramos sobre el widget y luego le damos Ctrl + . y ahí nos da la opción de removerlo
      // NOTA: Ahora no usamos un Column sino un Stack y recordemos que la diferencia es que el Stack permite colocar widgets
      //       unos sobre otros, y por lo tanto el que este primero es el que va a estar más atrás, y entre más abajo estén en
      //       el listado de children más al frente va a aestar.
      child: Stack(
        children: [
          // NOTA: Cargamos una imágen desde una url de internet a la cual le asignamos un id a partir del elevation
          //       y lo casteamos a entero, adicionalmente le colocamos unas dimensiones estáticas de 600 x 350
          Image.network(
            'https://picsum.photos/id/${elevation.toInt()}/600/350',
            height: 350,
            // NOTA: La propiedad fit especifica como queremos que la imágen se adapte a su espacio.
            fit: BoxFit.cover,
          ),

          // NOTA: El widget Align como su nombre lo indica sirve para alinea o hacer alineación de algún elemento hijo
          Align(
            alignment: Alignment.centerRight,
            // NOTA: Usamos un Contanier para hacer que el botón tenga una decoración, con un color y borde redondeado
            //       con el fin de que no se pierda ya que antes de colocar este container el botón casi no se veia.
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(20))),
              child: IconButton(
                icon: const Icon(Icons.more_vert_outlined),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
