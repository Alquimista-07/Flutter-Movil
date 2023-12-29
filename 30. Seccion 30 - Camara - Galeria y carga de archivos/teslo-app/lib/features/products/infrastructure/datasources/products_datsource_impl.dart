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

  // NOTA: Aplicando nuevamente el principio de responsabilidad única vamos a crear un método que se va a encargar de subir una única imágen,
  //       pero este método los vamos a combinar con el método para que sea llamado de alguna forma multiples veces por el método uploadPhotos
  //       y así cargar todos los archivos al backend de manera simultane.
  Future<String> _uploadFile(String path) async {
    try {
      // NOTA: Ocupamos el nombre del archivo y el cual a la final el backend renombra como un uid con la extensión de la imágen.
      //       Por lo tanto como sabemos que la imágen en cache va a quedar en una ruta lo que vamos a hacer es cortar por el /
      //       para separar en un arreglo de string y vamos a tomar la última posición correspondiente al nombre de la imágen
      //       con su extensión.
      final fileName = path.split('/').last;

      // NOTA: Esta data es la que va a contener la imágen, por lo tanto acá vamos a pasarle la llave que tiene el backend, que en este caso
      //       es file, y es super importante pasarle el mismo nombre de la llave y que esta definida en el backend, es decir, propia de la
      //       forma como esta desarrolado el backend.
      final FormData data = FormData.fromMap(
        {
          'file': MultipartFile.fromFileSync(
            path,
            filename: fileName,
          ),
        },
      );

      // Posto al endpoint del backend
      final response = await dio.post('/files/product', data: data);

      // NOTA: Ojo acá retornamos el response.data con la llave que viene en la respuesta del backend,
      //       que en este caso es image
      return response.data['image'];
    } catch (e) {
      throw Exception();
    }
  }

  // NOTA: Implementación del método para subir una imágen de forma correcta al backend.
  //       Este método en si se va a encargar de hacer la carga de múltiples imágenes y para así aplicar el principio de responsabilidad única.
  //       Por lo tanto lo que quiero hacer es un procedimiento con cada una de las fotografías que tengamos en el listado (photosToUpload) y
  //       quiero disparar unos procedimientos de forma simultanea, a pesar de que podríamos usar un await por cada uno de los elementos quiero
  //       hacerlo de forma simultanea.
  Future<List<String>> _uploadPhotos(List<String> photos) async {
    // NOTA: Tomamos todas las imágenes que tengan un /, es decir las que tengan el path local y que son las fotos que tenemso en el cache o filesystem del dispositivo
    //       antes de enviarlas al backend y lo transformamos en una lista.
    // OJO: Hay que tener en consideración si tuvieramos imágenes que tengan https:// y luego el url, entonces deberíamos ajutar o aplicar alguna lógica para recibir esos url,
    //      pero en este caso no es necesario ya que no vamos a tener fotos de ese tipo.
    final photosToUpload =
        photos.where((element) => element.contains('/')).toList();

    // NOTA: Ahora necesitamos obtener las fotos que vamos a ignorar y que serían las que ya tenemos almacenadas en el backend
    final photosToIgnore =
        photos.where((element) => !element.contains('/')).toList();

    // NOTA: Crear una serie de Futures de carga de imágenes
    //       OJO Recordemos que cuando tenemos un callback donde los argumentos que tiene el callback son los mismos que va
    //       a usar la función(_uploadFile) entonces simplemente podemos mandar como referencia la función sin argumentos.
    //       Es decir, pasamos de .map((e) => _uploadFile(e)) a tener simplemente .map(uploadFile))
    final List<Future<String>> uploadJob =
        photosToUpload.map(_uploadFile).toList();
    final newImages = await Future.wait(uploadJob);

    // Regresamos las fotos iniciales, y le agregamos las nuevas imágenes.
    return [
      ...photosToIgnore,
      ...newImages,
    ];
  }

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

      // NOTA: Mandamos todas las imágenes desde y hacia la lista, esto incluye las imágenes antiguas como las nuevas
      productLike['images'] = await _uploadPhotos(productLike['images']);

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
