import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:forms_app/infrastructure/inputs/inputs.dart';
import 'package:formz/formz.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterFormState> {
  RegisterCubit() : super(const RegisterFormState());

  void onSubmit() {
    print('Submit: ${state}');
  }

  // Métodos para cuando cambien los valores del username, email y password
  void usernameChanged(String value) {
    final username = Username.dirty(value);

    emit(state.copyWith(
      username: username,
      // NOTA: Es importante mandar las instancias de los demás inputs que se estan validando al método validate
      //       ya que esta función de validación necesita verificar cada uno de los campos para saber si es válido
      //       o no el formulario.
      isValid: Formz.validate([username, state.password]),
    ));
  }

  void emailChanged(String value) {
    emit(state.copyWith(
      email: value,
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);

    emit(state.copyWith(
      password: password,
      // NOTA: Es importante mandar las instancias de los demás inputs que se estan validando al método validate
      //       ya que esta función de validación necesita verificar cada uno de los campos para saber si es válido
      //       o no el formulario.
      isValid: Formz.validate([password, state.username]),
    ));
  }
}
