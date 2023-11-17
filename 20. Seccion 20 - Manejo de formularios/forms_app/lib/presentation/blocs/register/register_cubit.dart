import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterFormState> {
  RegisterCubit() : super(const RegisterFormState());

  void onSubmit() {
    print('Submit: ${state}');
  }

  // Métodos para cuando cambien los valores del username, email y password
  void usernameChanged(String value) {
    emit(state.copyWith(
      username: value,
    ));
  }

  void emailChanged(String value) {
    emit(state.copyWith(
      email: value,
    ));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(
      password: value,
    ));
  }
}
