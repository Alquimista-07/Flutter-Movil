import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';
import 'package:teslo_shop/features/shared/infrastucture/services/key_value_storage_service.dart';
import 'package:teslo_shop/features/shared/infrastucture/services/key_value_storage_service_impl.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
// NOTA: Como el loginUser, registerUser y checkAuthStatus a la final terminan delegando el llamado al repositorio,
//       por lo tanto podemos crearnos por acá ese llamado al repository y no le mandamos el datasource ya que le mandamos
//       uno por defecto
  final authRepository = AuthRepositoryImpl();

  // NOTA: Inyectamos el servicio que creamos de shared_preferences y que nos va a ayudar con el manejo del token
  //       referente a las operaciones de guardar, leer y eliminar dicho token.
  //       El enalce a la documentación de shared_preferences es el siguiente:
  //       https://pub.dev/packages/shared_preferences
  final keyValueStorageService = KeyValueStorageServiceImpl();

  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorageService: keyValueStorageService,
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;

  AuthNotifier({
    required this.authRepository,
    required this.keyValueStorageService,
  }) : super(AuthState()) {
    // NOTA: Realizamos la validación de la autenticación en base al token cuando el notifier se crea.
    checkAuthStatus();
  }

  Future<void> loginUser(String email, String password) async {
    // NOTA: Simulamos un retardo para poder apreciar bien el proceso, pero esto no es necesario colocarlo en la vida real
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('Error no controlado');
    }
  }

  Future<void> logout([String? errorMessage]) async {
    // NOTA: Limpiar token
    await keyValueStorageService.removeKey('token');

    state = state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        user: null,
        errorMessage: errorMessage);
  }

  void registerUser(String email, String password, String fullName) async {
    // NOTA: Simulamos un retardo para poder apreciar bien el proceso, pero esto no es necesario colocarlo en la vida real
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final user = await authRepository.register(email, password, fullName);
      _setRegisterUser(user);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('Error no controlado');
    }
  }

  void checkAuthStatus() async {
    // NOTA: Vamos a verificar si tenemos el token
    final token = await keyValueStorageService.getValue<String>('token');

    // NOTA: La razón por la que se manda a llamar el logout es que cuando se abre la aplicación por primera vez se establece el estado (AuthState)
    //       como checking, por lo tanto al ser checking nosotros tenemos que cambiar el estado a un notAuthenticated y por eso se llama el logout
    //       ya que al llamarlo establecemos ese estado de notAuthenticated.
    if (token == null) return logout();

    // NOTA: Pero si tenemos un token entonces procedemos a validarlo contra el backend y hacer todo lo demás
    try {
      final user = await authRepository.checkAuthStatus(token);
      _setLoggedUser(user);
    } catch (e) {
      logout();
    }
  }

  void _setLoggedUser(User user) async {
    // NOTA: Para grabar el token vamos a usar un paquete llamado shared_prefetences, que es uno de los más usados
    //       y es Flutter Favorite. Pero hay que tener en cuenta que este no es el único para este fin, ya que
    //       incluso podríamos usar Isar para esta tarea de almacenar de forma local el JWT del usuario.
    //       El enalce a la documentación de shared_preferences es el siguiente:
    //       https://pub.dev/packages/shared_preferences
    // NOTA: Guardar el token fisicamente
    await keyValueStorageService.setKeyValue('token', user.token);

    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
    );
  }

  void _setRegisterUser(User user) {
    state = state.copyWith(
        user: user, authStatus: AuthStatus.notAuthenticated, errorMessage: '');
  }
}

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = '',
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) =>
      AuthState(
        authStatus: authStatus ?? this.authStatus,
        user: user ?? this.user,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
