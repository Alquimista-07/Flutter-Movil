import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/presentation/providers/providers.dart';

// NOTA: Recordemos que el ConsumerWidget es la versión homologa al StatelessWidget y el ConsumerStatefullWidget es la homolga al StatefullWidget
class ProductScreen extends ConsumerWidget {
  final String productId;

  const ProductScreen({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // NOTA: Como el productProvider es un provider que tiene el modificador family() lo tenemos que llamar colocando los () y pasarle el argumento que este reciba que en este caso es el id del producto.
    // NOTA: OJOOOOOOOOOOOOO NOTA IMPORTANTE: Si este fuera un ConsumerStatefullWidget y no un ConsumerWidget y fueramos a usar el productProvider también este provider al tener el modificador family()
    //       si necesitaramos acceder al .notifier inmediatamente como lo hemos hecho con otros providers de riverpod que hemos creado anteriormente, por lo tanto, tenemos que mandarlo a llamar colocando
    //       los () y pasarle el argumento que este reciba que en este caso es el id del producto y luego si podemos mandar a llamar el .notifier
    //       Adicionalmente recordemos que usaríamos widget para acceder a una propiedad debido a que estoy dentro de un StatefullWidget o ConsumerStatefulWidget
    //
    //       Ejemplo:
    //
    //       ref.read(productProvider(widget.productId).notifier);
    //
    final productState = ref.watch(productProvider(productId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Producto'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt_outlined),
          )
        ],
      ),
      body: Center(
        child: Text(productState.product?.title ?? 'Cargando'),
      ),
      // NOTA: Algo que es chévere es que como tenemos un floatinActionButton en la pantalla de productos y acá agregamos otro, al cambiar entre pantallas
      //       este va a hacer una transición con una animación por defecto de forma automática y a esto se le conoce como un Hero animation en Flutter.
      //       Adicionalmente si queremos conocer más sobre este Hero Animation podemor ver video de Fernando que se encuentra en el siguiente enlace:
      //       https://www.youtube.com/watch?v=8IO6eqcTjNc&ab_channel=FernandoHerrera
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.save_as_outlined),
      ),
    );
  }
}
