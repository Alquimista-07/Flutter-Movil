import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
// NOTA: Como el loginUser, registerUser y checkAuthStatus a la final terminan delegando el llamado al repositorio,
//       por lo tanto podemos crearnos por acá ese llamado al repository y no le mandamos el datasource ya que le mandamos
//       uno por defecto
  final authRepository = AuthRepositoryImpl();

  return AuthNotifier(
    authRepository: authRepository,
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;

  AuthNotifier({required this.authRepository}) : super(AuthState());

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
    // TODO: Limpiar token

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

  void checkAuthStatus() async {}

  void _setLoggedUser(User user) {
    // TODO: Necesito guardar el token fisicamente

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
