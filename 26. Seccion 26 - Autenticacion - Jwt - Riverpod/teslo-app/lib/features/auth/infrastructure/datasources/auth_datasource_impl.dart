// NOTA: Recordemos que en infrastucture si vamos a hacer la implementación de los datasources y los repositories
import 'package:teslo_shop/features/auth/domain/domain.dart';

class AuthDatasourcesImpl extends AuthDatasource {
  @override
  Future<User> checkAuthStatus(Object token) {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
