import 'package:flutter/material.dart';

// NOTA: Vamos a crear unos slides, que fácilmente los podemos crear en un directorio aparte pero en este caso
//       como van a ser nada más tres entonces los vamos a crear acá
class SlideInfo {
  final String title;
  final String caption;
  final String imageUrl;

  // Constructor posicional
  SlideInfo(
    this.title,
    this.caption,
    this.imageUrl,
  );
}

final slides = <SlideInfo>[
  SlideInfo(
    'Busca la comida',
    'Non ullamco eiusmod eiusmod eu ipsum incididunt velit do enim enim.',
    'assets/images/1.png',
  ),
  SlideInfo(
    'Entrega rápida',
    'Non sunt ea culpa fugiat.',
    'assets/images/2.png',
  ),
  SlideInfo(
    'Disfruta la comida',
    'Officia occaecat laborum nostrud minim dolore consectetur.',
    'assets/images/3.png',
  ),
];

class AppTutorialScreen extends StatelessWidget {
  static const name = 'tutorial_screen';

  const AppTutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // NOTA: Usamos el widget PageView() que anteriormente usamos en la app toktik que creamos- Pero recordemos que este es un widget que toma
      //       el espacio disponible de la pantalla y si hacemos swipe vamos a tener otro y si hacemos swipe otra vez tenemos otro y así sucesivamente
      //       Otra cosa que hay que tener en cuenta de este widget es que su comportamiento por defecto es hacer swipe hacia los lados, y en caso de
      //       que quisieramos hacer swipe en forma horizontal tendríamos que cambiar el comportamiento usando la propiedad scrollDirection en vertical
      body: PageView(
          physics: const BouncingScrollPhysics(),
          // NOTA: El children del PageView tiene que ser una colección de widgets entonces en este caso podemos uar nuestra lista
          //       de slides y recorrerla. Ahora hay que tener en cuenta que esto es un iterable y lo que espera es una lista de
          //       widgets, entonces tenemos que transformalo a una lista con el método .toList()
          children: slides
              .map((slideData) => _Slide(
                    slideData.title,
                    slideData.caption,
                    slideData.imageUrl,
                  ))
              .toList()),
    );
  }
}

class _Slide extends StatelessWidget {
  // NOTA: Recibimos las propieades
  final String title;
  final String caption;
  final String imageUrl;

  const _Slide(
    this.title,
    this.caption,
    this.imageUrl,
  );

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
