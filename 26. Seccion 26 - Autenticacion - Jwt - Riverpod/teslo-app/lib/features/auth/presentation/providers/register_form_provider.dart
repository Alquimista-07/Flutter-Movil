import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/shared/infrastucture/inputs/inputs.dart';

//! 3 - StateNotifierProvider - Consume afuera
final registerFormProvider =
    StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>(
        (ref) {
  return RegisterFormNotifier();
});

//! 2 - Como impementamos un notifier
class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  RegisterFormNotifier() : super(RegisterFormState());

  onFullNameChanged(String value) {
    final newNombre = Nombre.dirty(value);

    state = state.copyWith(
      fullName: newNombre,
      isValid: Formz.validate(
          [newNombre, state.password, state.email, state.repitePassword]),
    );
  }

  onEmailChanged(String value) {
    final newEmail = Email.dirty(value);

    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate(
          [newEmail, state.fullName, state.password, state.repitePassword]),
    );
  }

  onPasswordChanged(String value) {
    final newPassword = Password.dirty(value);

    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate(
          [newPassword, state.fullName, state.email, state.repitePassword]),
    );
  }

  onRepitePasswordChanged(String value) {
    final newRepitePassword = Password.dirty(value);

    state = state.copyWith(
      repitePassword: newRepitePassword,
      isValid: Formz.validate(
          [newRepitePassword, state.fullName, state.email, state.password]),
    );
  }

  onFormSubmit() {
    _touchEveryField();

    if (!state.isValid) return;

    print(state);
  }

  void showCustomSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();

    final snackbar = SnackBar(
      content: const Text('Las contraseñas no son iguales'),
      action: SnackBarAction(label: 'OK', onPressed: () {}),
      duration: const Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  _touchEveryField() {
    final fullName = Nombre.dirty(state.fullName.value);
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final repitePassword = Password.dirty(state.repitePassword.value);

    state = state.copyWith(
      isFormPosted: true,
      fullName: fullName,
      email: email,
      password: password,
      repitePassword: repitePassword,
      isValid: Formz.validate([fullName, email, password, repitePassword]),
    );
  }
}

//! 1 - State del provider
class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Nombre fullName;
  final Email email;
  final Password password;
  final Password repitePassword;

  RegisterFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.fullName = const Nombre.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.repitePassword = const Password.pure(),
  });

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Nombre? fullName,
    Email? email,
    Password? password,
    Password? repitePassword,
  }) =>
      RegisterFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        password: password ?? this.password,
        repitePassword: repitePassword ?? this.repitePassword,
      );

  @override
  String toString() {
    return '''
      RegisterFormState
      isPosting: $isPosting
      isFormPosted: $isFormPosted
      isValid: $isValid
      fullName: $fullName
      email: $email
      password: $password
      repitePassword: $repitePassword
    ''';
  }
}
