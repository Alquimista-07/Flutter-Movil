// NOTA: Recordemos que en el domain van las reglas de negocio, osea las reglas de juego.
//       Por lo tanto el datasource solo va a ser la definición de como quiero que sea en este caso
//       los sistemas de autenticación que va a manejar la aplicación y los requisitos con los cuales
//       deben cumplir, permitiendo cambiarlos en un futuro.
import '../entities/user.dart';

abstract class AuthDatasource {
  Future<User> login(String email, String password);
  Future<User> register(String email, String password, String fullName);
  Future<User> checkAuthStatus(String token);
}
