// NOTA: Recordemos que en infrastucture si vamos a hacer la implementación de los datasources y los repositories
import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';

class AuthDatasourcesImpl extends AuthDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiUrl,
  ));

  @override
  Future<User> checkAuthStatus(Object token) {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio
          .post('/auth/login', data: {'email': email, 'password': password});

      final user = UserMapper.userJsonToEntity(response.data);

      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw WrongCredentials();
      if (e.type == DioExceptionType.connectionTimeout) {
        throw ConnectionTimeout();
      }
      throw CustomError('Something wrong happend', 1);
    } catch (e) {
      throw CustomError('Something wrong happend', 1);
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
