// NOTA: Recordemos que en el domain van las reglas de negocio, osea las reglas de juego.
//       Por lo tanto el repository solo va a ser la definición del datasource que vamos a usar para
//       autenticarnos.
import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> register(String email, String password, String fullName);
  Future<User> checkAuthStatus(String token);
}
