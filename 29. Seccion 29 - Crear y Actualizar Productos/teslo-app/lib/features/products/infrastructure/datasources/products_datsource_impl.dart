import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import '../errors/product_errors.dart';
import '../mappers/product_mapper.dart';

class ProductsDatasourceImpl extends ProductsDatasource {
  // NOTA: Acá vamos a hacer una implementación de Dio un poco diferente a las usadas veces anteriores como por ejemplo el auth de esta misma aplicación
  //       pero en este caso vamos a usar late para decirle que lo voy a configurara después, y cuando los métodos lo vayan a usar ya va a estar configurado
  late final Dio dio;

  // NOTA: Una cosa es que el endpoint para obtener los productos por pagina no ocupa el token, pero aún así lo vamos a usar para tener una referencia ya que
  //       los demás endpoint como el de creación si lo necesitan.
  final String accessToken;

  // NOTA: Vamos a mandar el token como requerido y posteriormente creamos la configuración  e inicialización de Dio
  ProductsDatasourceImpl({
    required this.accessToken,
  }) : dio = Dio(
          BaseOptions(
            baseUrl: Environment.apiUrl,
            headers: {
              'Authorization': 'Bearer $accessToken',
            },
          ),
        );

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) async {
    try {
      // NOTA: Para determinar si vamos a crear o actualizar un producto primero tenemos que determinar si tenemos un id, por lo tanto lo vamos a leer
      //       de la propiedad algo que luce como un producto (productLike)
      final String? productId = productLike['id'];

      // NOTA: Ahora como vamos a usar el mismo método para crear o actualizar vamos a determinar el método HTTP a usar.
      final String method = (productId == null) ? 'POST' : 'PATCH';

      // NOTA: De la misma forma que con el método determinamos la url
      final String url =
          (productId == null) ? '/products' : '/products/$productId';

      // OJO. El backend no nedesita propiamente que mandemos el id en el body cuando vamos a actualizar un producto ya que dicho id va en
      //      el url de la petición, por lo tanto ese es el que se usa para consultar y actualizar, por lo tanto el id que vaya en el body
      //      es necesario removerlo.
      productLike.remove('id');

      // NOTA: Ahora si usaramos este método para una sola tarea como un post o un patch usaríamos el método .post() o .patch() respectivamente
      //       pero como este método lo queremos para que haga las dos cosas dependiendo de si viene el id o no entonces vamos a usar es el método
      //       request() para crear la petición por así decirlo de forma manual.
      final response = await dio.request(
        url,
        data: productLike,
        options: Options(
          method: method,
        ),
      );

      final product = ProductMapper.jsonToEntity(response.data);

      return product;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<Product> getProductById(String id) async {
    try {
      final response = await dio.get('/products/$id');
      final product = ProductMapper.jsonToEntity(response.data);

      return product;
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) throw ProductNotFound();
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Product>> getProductsByPage(
      {int limit = 10, int offset = 0}) async {
    final response = await dio.get<List>(
      '/products',
      queryParameters: {
        'limit': limit,
        'offset': offset,
      },
    );

    final List<Product> products = [];

    // NOTA: La response puede que venga vacía entonces si viene vacía mandamos un listado vacío
    for (final product in response.data ?? []) {
      // Agregamos los resultados al listado
      products.add(ProductMapper.jsonToEntity(product));
    }

    return products;
  }

  @override
  Future<List<Product>> searchProductByTerm(String term) {
    // TODO: implement searchProductByTerm
    throw UnimplementedError();
  }
}
