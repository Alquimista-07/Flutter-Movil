import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'products_repository_provider.dart';

// PROVIDER
final productsProvider =
    StateNotifierProvider<ProductsNotifier, ProductsState>((ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);

  return ProductsNotifier(productsRepository: productsRepository);
});

// NOTIFIER
class ProductsNotifier extends StateNotifier<ProductsState> {
  final ProductsRepository productsRepository;

  ProductsNotifier({
    required this.productsRepository,
  }) :
        // NOTA: Cuando se cree creamos la instancia de nuestro state y llamamos el método leadNextPage inmediatamente
        super(ProductsState()) {
    loadNextPage();
  }

  Future loadNextPage() async {
    // NOTA: Para evitar el bomabardeo de peticiones al backend hacemos validaciones ya que esto sucede mucho cuando tenemos un inifinite scroll
    if (state.isLoading || state.isLastPage) return;

    // Caso contrario actualizamos el state para indicar que esta cargando
    state = state.copyWith(isLoading: true);

    final products = await productsRepository.getProductsByPage(
      limit: state.limit,
      offset: state.offset,
    );

    // NOTA: Puede que luego de hacer la petición los products vengan vacíos por lo tanto validamos si ya no tenemos productos
    //       por lo tanto actualizamos el estado para por ejemplo que deje de cargar y hacer peticiónes al backend, etc.
    if (products.isEmpty) {
      state = state.copyWith(
        isLoading: false,
        isLastPage: true,
      );
      return;
    }

    // NOTA: Pero si tenemos más productos
    state = state.copyWith(
        isLastPage: false,
        isLoading: false,
        offset: state.offset + 10,
        // NOTA: Con los productos hacemos un spread de los productos que tenía anteriormente en el estado y el spred de los nuevos productos
        products: [...state.products, ...products]);
  }
}

// STATE
// NOTA: El state es como quiero qu luzca la información del provider

class ProductsState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Product> products;

  ProductsState({
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.products = const [],
  });

  ProductsState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Product>? products,
  }) =>
      ProductsState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        products: products ?? this.products,
      );
}
