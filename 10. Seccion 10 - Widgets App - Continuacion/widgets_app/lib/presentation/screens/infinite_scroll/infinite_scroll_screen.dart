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
