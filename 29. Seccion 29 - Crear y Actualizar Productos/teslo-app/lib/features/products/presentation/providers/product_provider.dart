import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'products_repository_provider.dart';

// PROVIDER
// NOTA: Recorudemos que el autodispose sirve para que se limpie cada vez que ya no se va a utilizar
//       y el family se usa para esperar un valor al momento de utilizar el provider ya que se necesita
//       el id.
//       Adicionalmente como tenemos el family este va a esperar tres argumentos que sería el notifier, el state
//       y un String correspondiente al tipo del id del producto.
final productProvider = StateNotifierProvider.autoDispose
    .family<ProductNotifier, ProductState, String>((ref, productId) {
  // NOTA: Recordemos que el productsRepository la ventaja es que cuando nos autentiquemos y todo lo demás este se va a refrescar solo y va a esparcir el token en todos los lugares
  //       donde lo utilizo, siempre y cuando este centralizado y lo usemos en ese productsRepository
  final productsRepository = ref.watch(productsRepositoryProvider);

  return ProductNotifier(
    productsRepository: productsRepository,
    productId: productId,
  );
});

// NOTIFIER
class ProductNotifier extends StateNotifier<ProductState> {
  final ProductsRepository productsRepository;

  // NOTA: El super se ejecuta antes de que llegemos a llamar el constructor
  //       por lo tanto ya tenemos el id en el state y lo podemos usar para
  //       llamar el método que nos permite obtener el producto por id
  ProductNotifier({
    required this.productsRepository,
    required String productId,
  }) : super(ProductState(id: productId)) {
    loadProduct();
  }

  // NOTA: Este producto vacío lo vamos a usar para cuando vayamos a crear un producto,
  //       Por lo tanto va a tener unos valores por defecto que van a ser reemplazados
  //       cuando demos click en el botón guardar.
  Product _newEmptyProduct() {
    return Product(
      id: 'new',
      title: '',
      price: 0,
      description: '',
      slug: '',
      stock: 0,
      sizes: [],
      gender: '',
      tags: [],
      images: [],
    );
  }

  Future<void> loadProduct() async {
    try {
      // NOTA: Como vamos a reutilizar el formulario de editar producto necesitamos determinar o validar de alguna forma un id
      //       ficticio como por ejemplo /new que venga y el cual nos va a servir para determinar si vamos a crear un producto.
      if (state.id == 'new') {
        state = state.copyWith(
          isLoading: false,
          product: _newEmptyProduct(),
        );
        return;
      }

      final product = await productsRepository.getProductById(state.id);

      state = state.copyWith(
        isLoading: false,
        product: product,
      );
    } catch (e) {
      // 404 product nof found
      print(e);
    }
  }
}

// STATE
class ProductState {
  final String id;
  final Product? product;
  final bool isLoading;
  final bool isSaving;

  ProductState({
    required this.id,
    this.product,
    this.isLoading = true,
    this.isSaving = false,
  });

  ProductState copyWith({
    String? id,
    Product? product,
    bool? isLoading,
    bool? isSaving,
  }) =>
      ProductState(
        id: id ?? this.id,
        product: product ?? this.product,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
      );
}
