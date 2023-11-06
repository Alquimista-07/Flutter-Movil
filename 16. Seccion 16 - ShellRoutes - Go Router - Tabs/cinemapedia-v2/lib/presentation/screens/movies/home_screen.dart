import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  // NOTA: Ahora como vamos a incluir otras vistas necesitamos de alguna forma pasar que índice correspondiente al tab es al que
  //       se quiere navegar por lo tanto creamos una propiedad que nos va a ayudar.
  final int pageIndex;

  const HomeScreen({super.key, required this.pageIndex});

  // NOTA: Creamos un listado de widgets con las vistas
  final viewRoutes = const <Widget>[
    HomeView(),
    SizedBox(), // <----- categorias view
    FavoritesView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // NOTA: Ahora para el tema de preservar el estado y tener el KeepAlive, existe un widget de Flutter que me sirve para eso que es el
      //       IndexedStack
      body: IndexedStack(
        index: pageIndex,
        // NOTA: Y el children va a ser toda la colección de widgets que van a servirme para estarlos cambiando
        //       en base a lo que tenga el pageIndex
        children: viewRoutes,
      ),
      // NOTA: Acá vamos a agregar el bottom navigation bar, y sobre el cual podemos ver un ejemplo en el
      //       siguiente enlace: https://www.youtube.com/watch?v=HB5WMcxAmQQ&ab_channel=FernandoHerrera
      //       si queremos saber más de él.
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}
