import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeView(),
      // NOTA: Acá vamos a agregar el bottom navigation bar, y sobre el cual podemos ver un ejemplo en el
      //       siguiente enlace: https://www.youtube.com/watch?v=HB5WMcxAmQQ&ab_channel=FernandoHerrera
      //       si queremos saber más de él.
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}
