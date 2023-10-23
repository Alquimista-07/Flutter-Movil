import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

class AppTutorialScreen extends StatefulWidget {
  static const name = 'tutorial_screen';

  const AppTutorialScreen({super.key});

  @override
  State<AppTutorialScreen> createState() => _AppTutorialScreenState();
}

class _AppTutorialScreenState extends State<AppTutorialScreen> {
  // NOTA: Creamos la propiedad para el controlador
  final PageController pageViewController = PageController();
  // NOTA: Creamos una bandera booleana para saber cuando llegamos al final del slide
  bool endReached = false;

  @override
  void initState() {
    // NOTA: Recordemos que en el initState se llama o dejamos primero el super.initState
    super.initState();

    // NOTA: Ahora colocamos un listener
    pageViewController.addListener(() {
      // print('${pageViewController.page}');
      // NOTA: Determinamos cuando lleguemos a la última pantalla
      final page = pageViewController.page ?? 0;

      // NOTA: OJO recordemos que con el print veiamos que como tal el page contiene valores double
      //       y por lo tanto acá dejamos el -1.5 para mostrar el botón antes de que se llegue al 2
      //       que sería el final del slide.
      if (!endReached && page >= (slides.length - 1.5)) {
        // NOTA: Ojo hay que tener cuidado cuando llamemos el setState ya que se puede ejecutar muchas veces ya que como vimos con el print del page
        //       se renderiza muchas veces y por eso lo llamamos es dentro de esta condición para que se ejecute solo cuando se cumpla.
        setState(() {
          endReached = true;
        });
      }
    });
  }

  // NOTA: OJO otra cosa muy importante y casi que obligatoria es que cada vez que usemos un listener o un controller debemos mandar a llamar el dispose
  //       que hace parte del ciclo de vida de los statefulwidgets con el fin de limpiar los listeners y controladores y no tener fugas de memoria.
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // NOTA: Usamos el widget PageView() que anteriormente usamos en la app toktik que creamos- Pero recordemos que este es un widget que toma
      //       el espacio disponible de la pantalla y si hacemos swipe vamos a tener otro y si hacemos swipe otra vez tenemos otro y así sucesivamente
      //       Otra cosa que hay que tener en cuenta de este widget es que su comportamiento por defecto es hacer swipe hacia los lados, y en caso de
      //       que quisieramos hacer swipe en forma horizontal tendríamos que cambiar el comportamiento usando la propiedad scrollDirection en vertical
      body: Stack(
        children: [
          PageView(
              controller: pageViewController,
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
          // NOTA: Colocamos un botón para saltar el tutorial
          Positioned(
            right: 20,
            top: 50,
            child: TextButton(
              child: const Text('Salir'),
              onPressed: () => context.pop(),
            ),
          ),
          // NOTA: Usamos la bandera para mostrar de forma condicional el botón cuando lleguemos al final del slide
          endReached
              ? Positioned(
                  bottom: 30,
                  right: 30,
                  // NOTA: Adicionalmente usando el paquete animtad_do le agregamos una animación al FilledButton
                  child: FadeInRight(
                    // NOTA: Indicamos que solo se mueva 15 unidades
                    from: 15,
                    // NOTA: Indicamos que no entre inmediatamente sino que tenga un pequeño retraso
                    delay: const Duration(seconds: 1),
                    child: FilledButton(
                      child: const Text('Comenzar'),
                      onPressed: () => context.pop(),
                    ),
                  ),
                )
              // NOTA: Acá como no ocupamos mostrar nada podemos usar un widget SizedBox el cual se recomienda usar para no mostrar ningún widget
              : const SizedBox(),
        ],
      ),
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
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final captionStyle = Theme.of(context).textTheme.bodySmall;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Center(
        child: Column(
          // NOTA: EL mainAxisAlignment aplica en la orientación vertical
          mainAxisAlignment: MainAxisAlignment.center,
          // NOTA: El crossAxisAlignment aplica en la orientación horizontal
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: AssetImage(imageUrl),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: titleStyle,
            ),
            const SizedBox(height: 10),
            Text(
              caption,
              style: captionStyle,
            ),
          ],
        ),
      ),
    );
  }
}
