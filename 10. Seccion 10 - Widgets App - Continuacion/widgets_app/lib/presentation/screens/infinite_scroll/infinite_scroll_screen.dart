import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InfiniteScrollScreen extends StatefulWidget {
  static const name = 'infinite_screen';

  const InfiniteScrollScreen({super.key});

  @override
  State<InfiniteScrollScreen> createState() => _InfiniteScrollScreenState();
}

class _InfiniteScrollScreenState extends State<InfiniteScrollScreen> {
  List<int> imagesIds = [1, 2, 3, 4, 5];

  // NOTA: Creamos el controlador
  final ScrollController scrollController = ScrollController();

  // NOTA: Como el listener va a estarse disparando varias veces necesitamos controlar y para ello usamos una bandera
  bool isLoading = false;
  bool isMounted = true;

  @override
  void initState() {
    super.initState();
    // NOTA: Agregamos el listener
    // NOTA: Y La idea es que si estoy al final quiero cargar el scroll pero para eso necesitamos determinar el final
    //       entonces dentro del listener vamos a usar el position.pixels de controlador para determinar los pixeles
    //       que hay actualmente y adicionalmente tenemos el position.maxScrollExtend que sirve para saber lo máximo
    //       que puede llegar
    scrollController.addListener(() {
      // NOTA: Le sumamos 500 para dar como holgura o un espacio de gracia antes de llegar al final
      if ((scrollController.position.pixels + 500) >=
          scrollController.position.maxScrollExtent) {
        // Load next page.
        loadNextPage();
      }
    });
  }

// NOTA: El dispose se llama cuando el componente esta siendo destruido, o va a ser destruido o ya no existe
  @override
  void dispose() {
    scrollController.dispose();
    // NOTA: Cambiamos la bandera para saber si el componente esta montado
    isMounted = false;
    super.dispose();
  }

  // NOTA: Simulamos una labor asíncrona
  Future loadNextPage() async {
    if (isLoading) return;

    isLoading = true;
    // NOTA: Llamamos el cambio de estado para que redibuje
    setState(() {});

    await Future.delayed(const Duration(seconds: 2));

    addFiveImages();
    isLoading = false;

    // NOTA: Llamamos el cambio de estado para que redibuje
    // TODO: Revisar si esta montado el componente / widget
    if (!isMounted) return;

    setState(() {});
  }

  void addFiveImages() {
    // NOTA: Obtenemos el último id
    final lastId = imagesIds.last;

    // NOTA: Barremos los elementos e insertamos 5 impagenes más
    imagesIds.addAll([1, 2, 3, 4, 5].map((e) => lastId + e));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pop(),
        child: const Icon(Icons.arrow_back_ios_new_outlined),
      ),
      // NOTA: El ListView lo envolvemos en un nuevo widget que es el MediaQuery el cual tiene un método que nos permite remover los padding o bordes
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true, // NOTA: Removemos el padding la parte superior
        removeBottom: true, // NOTA: Removemos el padding de la parte inferior
        child: ListView.builder(
          controller: scrollController,
          itemCount: imagesIds.length,
          itemBuilder: (context, index) {
            // NOTA: Usamos un nuevo widget que es el FadeInImage el cual es muy útil ya que nos permite cargar la imágen y mientras
            //       carga la imágen mostrar el placeholder image, el cual dicho placeholder tiene que ser una imágen que ya nosotros
            //       tenefor de forma rápida que por ejemplo puede estar en memoria cargada previamente o que sea un asset
            return FadeInImage(
              fit: BoxFit.cover,
              width: double.infinity,
              height: 300,
              placeholder: const AssetImage('assets/images/jar-loading.gif'),
              image: NetworkImage(
                  'https://picsum.photos/id/${imagesIds[index]}/500/300'),
            );
          },
        ),
      ),
    );
  }
}
