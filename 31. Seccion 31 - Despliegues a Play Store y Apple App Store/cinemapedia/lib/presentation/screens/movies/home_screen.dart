import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  static const name = 'home-screen';

  // NOTA: Ahora como vamos a incluir otras vistas necesitamos de alguna forma pasar que índice correspondiente al tab es al que
  //       se quiere navegar por lo tanto creamos una propiedad que nos va a ayudar.
  final int pageIndex;

  const HomeScreen({
    super.key,
    required this.pageIndex,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//* NOTA: Este Mixin es necesario para mantener el estado en el PageView
class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(keepPage: true);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  // NOTA: Creamos un listado de widgets con las vistas
  final viewRoutes = const <Widget>[
    HomeView(),
    PopularView(), // <----- populares view
    FavoritesView(),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (pageController.hasClients) {
      pageController.animateToPage(
        widget.pageIndex,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 250),
      );
    }

    return Scaffold(
      // NOTA: Ahora para el tema de preservar el estado y tener el KeepAlive, hacemos unos ajustes para usar un PageView el cual a través
      //       de un Mixin guardamos el estado y que anteriormente lo estabamos haciendo con un IndexedStack
      body: PageView(
        //index: widget.pageIndex,
        //* Esto evitará que rebote
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        // NOTA: Y el children va a ser toda la colección de widgets que van a servirme para estarlos cambiando
        //       en base a lo que tenga el pageIndex
        children: viewRoutes,
      ),
      // NOTA: Acá vamos a agregar el bottom navigation bar, y sobre el cual podemos ver un ejemplo en el
      //       siguiente enlace: https://www.youtube.com/watch?v=HB5WMcxAmQQ&ab_channel=FernandoHerrera
      //       si queremos saber más de él.
      bottomNavigationBar:
          CustomBottomNavigation(currentIndex: widget.pageIndex),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
