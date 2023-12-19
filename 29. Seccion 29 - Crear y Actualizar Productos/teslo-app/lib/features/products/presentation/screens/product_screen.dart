import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/presentation/providers/providers.dart';

class ProductScreen extends ConsumerStatefulWidget {
  final String productId;

  const ProductScreen({
    super.key,
    required this.productId,
  });

  @override
  ProductScreenState createState() => ProductScreenState();
}

class ProductScreenState extends ConsumerState<ProductScreen> {
  @override
  void initState() {
    super.initState();
    // NOTA: Como el productProvider es un provider que tiene el modificador family() por lo tanto no podemos acceder al .notifier inmediatamente
    //       como lo hacemos hecho con otros providers de riverpod que hemos creado anteriormente, por lo tanto, tenemos que mandarlo a llamar
    //       colocando los () y pasarle el argumento que este reciba que en este caso es el id del producto y luego si podemos mandar a llamar el
    //       .notifier
    // NOTA: Recordemos que usamos widget para acceder a una propiedad debido a que estoy dentro de un StatefullWidget o ConsumerStatefulWidget
    ref.read(productProvider(widget.productId).notifier);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Producto'),
      ),
      body: Center(
        child: Text(widget.productId),
      ),
    );
  }
}
