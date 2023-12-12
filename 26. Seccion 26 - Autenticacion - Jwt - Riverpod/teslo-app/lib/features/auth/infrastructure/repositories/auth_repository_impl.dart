// NOTA: Recordemos que en infrastucture si vamos a hacer la implementación de los datasources y los repositories
import 'package:teslo_shop/features/auth/domain/domain.dart';
import '../infrastructure.dart';

// NOTA: La idea del repositorio acá es que fácilmentenos permita hacer los cambios de los datasources
class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource datasource;

  // NOTA: Es muy probable que nosotros nunca cambiemos el datasource ya que este es el que se pega a la autenticación de la empresa,
  //       pero puede ser que en un futuro si. Por lo tanto yo no quiero forzar a estar creando la implementación del datasource si ya
  //       se cual se va a estar usando por defecto, por lo tanto lo mandamos opcional y le decimos que si lo tiene uselo y si no que cree
  //       la instancia del AuthDatsourceImpl
  AuthRepositoryImpl(
    AuthDatasource? datasource,
  ) : datasource = datasource ?? AuthDatasourcesImpl();

  @override
  Future<User> checkAuthStatus(String token) {
    return datasource.checkAuthStatus(token);
  }

  @override
  Future<User> login(String email, String password) {
    return datasource.login(email, password);
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    return datasource.register(email, password, fullName);
  }
}
