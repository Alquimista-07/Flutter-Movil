import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';

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
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) {
    // TODO: implement createUpdateProduct
    throw UnimplementedError();
  }

  @override
  Future<Product> getProductById(String id) {
    // TODO: implement getProductById
    throw UnimplementedError();
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
      // products.add(); // crear mapper
    }

    return products;
  }

  @override
  Future<List<Product>> searchProductByTerm(String term) {
    // TODO: implement searchProductByTerm
    throw UnimplementedError();
  }
}
