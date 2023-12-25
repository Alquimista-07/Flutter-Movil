import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/presentation/providers/providers.dart';
import 'package:teslo_shop/features/shared/shared.dart';

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
      // NOTA: Concición para mostrar la vista o el loader
      body: productState.isLoading
          ? const FullScreenLoader()
          : _ProductView(product: productState.product!),
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

//----------------------------
// Vista Productos
//----------------------------
class _ProductView extends ConsumerWidget {
  final Product product;

  const _ProductView({required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // NOTA: Para conectar el formulario con el provider es necesario mandarle el producto, y lo genial de Riverpod es que va a establecer el producto
    //       gracias a que va a crear la instancia del provider en el providerScope y no importan cuentas referencias tengamos del mismo siempre van a
    //       tener el mismo valor.
    //       Adicinalmente ya nuestro productForm ya tiene toda la data necesaria por lo tanto podriamos tomar los valores desde ahí y no desde el producto
    final productForm = ref.watch(productFormProvider(product));

    final textStyles = Theme.of(context).textTheme;

    return ListView(
      children: [
        SizedBox(
          height: 250,
          width: 600,
          child: _ImageGallery(images: productForm.images),
        ),
        const SizedBox(height: 10),
        Center(
            child: Text(productForm.title.value, style: textStyles.titleSmall)),
        const SizedBox(height: 10),
        _ProductInformation(product: product),
      ],
    );
  }
}

class _ProductInformation extends ConsumerWidget {
  final Product product;
  const _ProductInformation({required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // NOTA: Para conectar el formulario con el provider es necesario mandarle el producto, y lo genial de Riverpod es que va a establecer el producto
    //       gracias a que va a crear la instancia del provider en el providerScope y no importan cuentas referencias tengamos del mismo siempre van a
    //       tener el mismo valor.
    //       Adicinalmente ya nuestro productForm ya tiene toda la data necesaria por lo tanto podriamos tomar los valores desde ahí y no desde el producto
    final productForm = ref.watch(productFormProvider(product));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Generales'),
          const SizedBox(height: 15),
          CustomProductField(
            isTopField: true,
            label: 'Nombre',
            initialValue: productForm.title.value,
            onChanged:
                // NOTA: Recordemos que cuando tenemos una función cuyos argumentos son los mismos argumentos que vamos a mandar unicamente
                //       como referencia a la otra función, entonces simplemente podemos mandar como referencia la función.
                ref.read(productFormProvider(product).notifier).onTitleChanged,
            errorMessage: productForm.title.errorMessage,
          ),
          CustomProductField(
            label: 'Slug',
            initialValue: productForm.slug.value,
            onChanged:
                ref.read(productFormProvider(product).notifier).onSlugChanged,
            errorMessage: productForm.slug.errorMessage,
          ),
          CustomProductField(
            isBottomField: true,
            label: 'Precio',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            initialValue: productForm.price.value.toString(),
            onChanged:
                // NOTA: Acá como la función onPriceChanged espera un double y el onChanged recibe un String es necesario parsear a double.
                //       Pero en lugar de usar el método parse convencional vamos a usar el tryParse para que intente hacer el parseo y si
                //       no lo logra lo que vamos a hacer es mandarle un cero por defecto y esto lo hacemos es para evitar posibles errores
                //       en caso de que no logre parsear por algún motivo.
                (value) => ref
                    .read(productFormProvider(product).notifier)
                    .onPriceChanged(double.tryParse(value) ?? 0),
            errorMessage: productForm.price.errorMessage,
          ),
          const SizedBox(height: 15),
          const Text('Extras'),
          _SizeSelector(selectedSizes: product.sizes),
          const SizedBox(height: 5),
          _GenderSelector(selectedGender: product.gender),
          const SizedBox(height: 15),
          CustomProductField(
            isTopField: true,
            label: 'Existencias',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            initialValue: productForm.inStock.value.toString(),
            // NOTA: Acá como la función onStockChanged espera un int y el onChanged recibe un String es necesario parsear a int.
            //       Pero en lugar de usar el método parse convencional vamos a usar el tryParse para que intente hacer el parseo y si
            //       no lo logra lo que vamos a hacer es mandarle un cero por defecto y esto lo hacemos es para evitar posibles errores
            //       en caso de que no logre parsear por algún motivo.
            onChanged: (value) => ref
                .read(productFormProvider(product).notifier)
                .onStockChanged(int.tryParse(value) ?? 0),
            errorMessage: productForm.inStock.errorMessage,
          ),
          CustomProductField(
            maxLines: 6,
            label: 'Descripción',
            keyboardType: TextInputType.multiline,
            initialValue: product.description,
          ),
          CustomProductField(
            isBottomField: true,
            maxLines: 2,
            label: 'Tags (Separados por coma)',
            keyboardType: TextInputType.multiline,
            initialValue: product.tags.join(', '),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class _SizeSelector extends StatelessWidget {
  final List<String> selectedSizes;
  final List<String> sizes = const ['XS', 'S', 'M', 'L', 'XL', 'XXL', 'XXXL'];

  const _SizeSelector({required this.selectedSizes});

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      emptySelectionAllowed: true, // Puede ser que no tengamos una talla
      showSelectedIcon: false,
      segments: sizes.map((size) {
        return ButtonSegment(
            value: size,
            label: Text(size, style: const TextStyle(fontSize: 10)));
      }).toList(),
      selected: Set.from(selectedSizes),
      onSelectionChanged: (newSelection) {
        print(newSelection);
      },
      multiSelectionEnabled: true,
    );
  }
}

class _GenderSelector extends StatelessWidget {
  final String selectedGender;
  final List<String> genders = const ['men', 'women', 'kid'];
  final List<IconData> genderIcons = const [
    Icons.man,
    Icons.woman,
    Icons.boy,
  ];

  const _GenderSelector({required this.selectedGender});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SegmentedButton(
        emptySelectionAllowed: false, // Deberíamos tener seleccionado un genero
        multiSelectionEnabled: false,
        showSelectedIcon: false,
        style: const ButtonStyle(visualDensity: VisualDensity.compact),
        segments: genders.map((size) {
          return ButtonSegment(
              icon: Icon(genderIcons[genders.indexOf(size)]),
              value: size,
              label: Text(size, style: const TextStyle(fontSize: 12)));
        }).toList(),
        selected: {selectedGender},
        onSelectionChanged: (newSelection) {
          print(newSelection);
        },
      ),
    );
  }
}

class _ImageGallery extends StatelessWidget {
  final List<String> images;
  const _ImageGallery({required this.images});

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: PageController(viewportFraction: 0.7),
      children: images.isEmpty
          ? [
              ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Image.asset('assets/images/no-image.jpg',
                      fit: BoxFit.cover))
            ]
          : images.map((e) {
              return ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Image.network(
                  e,
                  fit: BoxFit.cover,
                ),
              );
            }).toList(),
    );
  }
}
