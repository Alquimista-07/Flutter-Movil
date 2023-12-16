import '../entities/product.dart';

abstract class ProductsDatasource {
  // NOTA: Obtener los producto de forma pagindada donde mandamos el limite y el offset opcionales con un valor por defecto
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 0});

  // NOTA: Obtrener producto por id
  Future<Product> getProductById(String id);

  // NOTA: Buscar producto por término
  Future<List<Product>> searchProductByTerm(String term);

  // Crear actualizar producto
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike);
}
