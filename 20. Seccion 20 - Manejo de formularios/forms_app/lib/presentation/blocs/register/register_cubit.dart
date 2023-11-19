import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:forms_app/infrastructure/inputs/inputs.dart';
import 'package:formz/formz.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterFormState> {
  RegisterCubit() : super(const RegisterFormState());

  void onSubmit() {
    // NOTA: Acá quiero poner al formulario en un estado nuevo cuando se postea el cual va a indicar que ya no esta en estado puro (pure)
    //       y por lo tanto se deben realizar las validaciones
    emit(state.copyWith(
        formStatus: FormStatus.validating,
        // NOTA: Hacemos que el dirty ahora tenga el valor actual que tenga el estado para que en caso de que este vacío y en estado pure y se haga un posteo esto va a hacer que lo ensucie
        //       y por lo tanto ya no va a estar pure y va a chocar contra la validación.
        username: Username.dirty(state.username.value),
        password: Password.dirty(state.password.value),
        email: Email.dirty(state.email.value),
        isValid: Formz.validate([
          state.username,
          state.email,
          state.password,
        ])));

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
      isValid: Formz.validate([username, state.password, state.email]),
    ));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.username, state.password])));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);

    emit(state.copyWith(
      password: password,
      // NOTA: Es importante mandar las instancias de los demás inputs que se estan validando al método validate
      //       ya que esta función de validación necesita verificar cada uno de los campos para saber si es válido
      //       o no el formulario.
      isValid: Formz.validate([password, state.username, state.email]),
    ));
  }
}
