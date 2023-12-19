// NOTA: Recordemos que en infrastucture si vamos a hacer la implementación de los datasources y los repositories
import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';

class AuthDatasourcesImpl extends AuthDatasource {
  // NOTA: OJO en este caso para dio no implementamos el patron adaptador a diferencia de como realizamos con los environment
  //       cuando creamos el archivo environment dentro del directorio constants. La ventaja de usar ese patrón adaptador es que
  //       de esa forma creamos un wraper o envoltura al rededor del dotenv y allá solo tenemos la referencia al paquete dotenv
  //       y en el caso de que luego quiera cambiar la forma de leer las variables de entorno entonces solo tengo un archivo que
  //       modificar. Por lo tanto con dio podríamos hacer algo muy similar y envolver el BaseOptions en una sola clase y evitar
  //       tener dependencias en varios lugares y si el dia de mañana cambia algo la aplicación no se va a ver afectada.
  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiUrl,
  ));

  @override
  Future<User> checkAuthStatus(Object token) async {
    try {
      // NOTA: Obtenemos el Bearer token de los headers
      final response = await dio.get('/auth/check-status',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));

      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError('Token incorrecto');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio
          .post('/auth/login', data: {'email': email, 'password': password});

      final user = UserMapper.userJsonToEntity(response.data);

      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(
            e.response?.data['message'] ?? 'Credenciales incorrectas');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Revisar conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) async {
    try {
      final response = await dio.post('/auth/register',
          data: {'email': email, 'password': password, 'fullName': fullName});

      final user = UserMapper.userJsonToEntity(response.data);

      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw CustomError(e.response?.data['message'] ??
            'Datos ingresados de forma incorrecta');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Revisar conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}
