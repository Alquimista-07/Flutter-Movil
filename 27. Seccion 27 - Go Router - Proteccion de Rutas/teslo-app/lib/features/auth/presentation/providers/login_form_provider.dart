import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/shared/shared.dart';

//! 3 - StateNotifierProvider - Consume afuera
final loginFormProvider =
// NOTA: Recordemos que el autoDispose destruye y reinicia la información diligenciada en los campos del formulario.
    StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
  // NOTA: Para evitar una dependencia oculta mandamos acá la referencia al provider
  final loginUserCallback = ref.watch(authProvider.notifier).loginUser;

  return LoginFormNotifier(
    loginUserCallback: loginUserCallback,
  );
});

//! 2 - Como impementamos un notifier
// NOTA: Estado para manejdar los campos del login
class LoginFormNotifier extends StateNotifier<LoginFormState> {
  // Recibimos la función
  final Function(String, String) loginUserCallback;

  // NOTA: En el super mandamos la creación del estado inicial
  LoginFormNotifier({required this.loginUserCallback})
      : super(LoginFormState());

  onEmailChanged(String value) {
    final newEmail = Email.dirty(value);

    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail, state.password]),
    );
  }

  onPasswordChanged(String value) {
    final newPassword = Password.dirty(value);

    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([newPassword, state.email]),
    );
  }

  onFormSubmit() async {
    _touchEveryField();

    if (!state.isValid) return;

    // print(state);
    await loginUserCallback(state.email.value, state.password.value);
  }

  // NOTA: Ocupamos este método para que cuando el campo toquemos el botón de ingresar todos los campos queden tocados o sucios,
  //       es decir, que ya no tengan un estado pure para que esto dispare las validaciones
  _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    state = state.copyWith(
      isFormPosted: true,
      email: email,
      password: password,
      isValid: Formz.validate([email, password]),
    );
  }
}

//! 1 - State del provider
// NOTA: Esto es como va a lucir nuestro state
class LoginFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;

  LoginFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
  });

  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
  }) =>
      LoginFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  @override
  String toString() {
    return '''
      LoginFormState
      isPosting: $isPosting
      isFormPosted: $isFormPosted
      isValid: $isValid
      email: $email
      password: $password
    ''';
  }
}
