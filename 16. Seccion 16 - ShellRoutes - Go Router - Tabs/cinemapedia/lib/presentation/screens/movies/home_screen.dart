import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  // NOTA: Por lo tanto cfomo separamos ahora nuestro home de su vista en un archivo independiente vamos a tener que ocupar
  //       una nueva propiedad obligatoria para indicar cual es la vista que se va a renderizar, y esta vista a ser indicada
  //       en nuestro router. Por lo tanto el go_router le va a decir cuando yo quiera mostrar el homeScreen cual es esa vista
  //       que se quiere mostrar y esa vista se cambia en el body por lo tanto no se recrea ni se destruye el bottomNavigationBar
  final Widget childView;

  const HomeScreen({super.key, required this.childView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: childView,
      ),
      // NOTA: Acá vamos a agregar el bottom navigation bar, y sobre el cual podemos ver un ejemplo en el
      //       siguiente enlace: https://www.youtube.com/watch?v=HB5WMcxAmQQ&ab_channel=FernandoHerrera
      //       si queremos saber más de él.
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}
