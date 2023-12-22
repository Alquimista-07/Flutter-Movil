import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/shared/infrastucture/inputs/inputs.dart';

// NOTIFIER
// NOTA: El notifier va a cumplir la manera de mantener el estado y sus cambios, pero adicionalmente va a ser el responsable de emitir la data
//       que tiene que ser procesada por otro ente
class ProductFormNotifier extends StateNotifier<ProductFormState> {
  // NOTA: La idea de este Function es que eventualmente cuando se mande llamar el submit del formulario se va a llamar esta función onSubmitCallback
  //       es decir, vamos a intentar mandar la información y ahí vamos a validar el formaulario también, que todos los campos estén llenos, hacer todo
  //       el procedimiento para verificar antes de llegar al backend que el formulario cumpla las reglas de validación.
  final void Function(Map<String, dynamic> productLike)? onSubmitCallback;

  ProductFormNotifier({
    this.onSubmitCallback,
    // NOTA: Esta propiedad product no la pedimos como propiedad sino que la recibimos ya que a pesar de que el formulario sirve para crear también sirve para actualizar un producto
    //       por lo tanto necesitamos recibir ese producto y crearle su estado inicial en el super con cada una de las propiedades
    required Product product,
  }) : super(
          ProductFormState(
              id: product.id,
              title: Title.dirty(product.title),
              slug: Slug.dirty(product.slug),
              price: Price.dirty(product.price),
              inStock: Stock.dirty(product.stock),
              sizes: product.sizes,
              gender: product.gender,
              description: product.description,
              // NOTA: Como los tags espera un listado lo que podemos hacer es unitlo y separalo por comas
              tags: product.tags.join(', '),
              images: product.images),
        );

  // Métodos para modificar los valores desde el formulario
  // NOTA: Acá solo vamos a validar los valores a los cuales les creamos los input con Formz, si quisieramos por ejemplo validar la descripcióin
  //       podríamos crear un nuevo input o simplemente tomarlo y validar la longitdo agregando un && luego del Formz.Validate([]).
  //       Para conocer más o ver como se puede hacer esto ir a la lección número 421. Product Form Provider - Notifier del curso

  void onTitleChanged(String value) {
    state = state.copyWith(
        title: Title.dirty(value),
        isFormValid: Formz.validate([
          Title.dirty(value),
          Slug.dirty(state.slug.value),
          Price.dirty(state.price.value),
          Stock.dirty(state.inStock.value),
        ]));
  }

  void onSlugChanged(String value) {
    state = state.copyWith(
        slug: Slug.dirty(value),
        isFormValid: Formz.validate([
          Title.dirty(state.title.value),
          Slug.dirty(value),
          Price.dirty(state.price.value),
          Stock.dirty(state.inStock.value),
        ]));
  }

  void onPriceChanged(double value) {
    state = state.copyWith(
        price: Price.dirty(value),
        isFormValid: Formz.validate([
          Title.dirty(state.title.value),
          Slug.dirty(state.slug.value),
          Price.dirty(value),
          Stock.dirty(state.inStock.value),
        ]));
  }

  void onStockChanged(int value) {
    state = state.copyWith(
        inStock: Stock.dirty(value),
        isFormValid: Formz.validate([
          Title.dirty(state.title.value),
          Slug.dirty(state.slug.value),
          Price.dirty(state.price.value),
          Stock.dirty(value),
        ]));
  }
}

// STATE
class ProductFormState {
  final bool isFormValid;
  final String? id;
  final Title title;
  final Slug slug;
  final Price price;
  final List<String> sizes;
  final String gender;
  final Stock inStock;
  final String description;
  final String tags;
  final List<String> images;

  ProductFormState({
    this.isFormValid = false,
    this.id,
    this.title = const Title.dirty(''),
    this.slug = const Slug.dirty(''),
    this.price = const Price.dirty(0),
    this.sizes = const [],
    this.gender = 'men',
    this.inStock = const Stock.dirty(0),
    this.description = '',
    this.tags = '',
    this.images = const [],
  });

  ProductFormState copyWith({
    bool? isFormValid,
    String? id,
    Title? title,
    Slug? slug,
    Price? price,
    List<String>? sizes,
    String? gender,
    Stock? inStock,
    String? description,
    String? tags,
    List<String>? images,
  }) =>
      ProductFormState(
        isFormValid: isFormValid ?? this.isFormValid,
        id: id ?? this.id,
        title: title ?? this.title,
        slug: slug ?? this.slug,
        price: price ?? this.price,
        sizes: sizes ?? this.sizes,
        gender: gender ?? this.gender,
        inStock: inStock ?? this.inStock,
        description: description ?? this.description,
        tags: tags ?? this.tags,
        images: images ?? this.images,
      );
}
