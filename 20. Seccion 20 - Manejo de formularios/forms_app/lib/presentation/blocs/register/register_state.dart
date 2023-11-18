part of 'register_cubit.dart';

// NOTA: También sería conveniente que nosotros pudieramos determinar el estado completo del formulario
//       ya que pueden haber mínimo tres estados, por lo tanto nos vamos a apoyar en una enumarción
enum FormStatus { invalid, valid, validating, posting }

class RegisterFormState extends Equatable {
  final FormStatus formStatus;
  final bool isValid;
  final Username username;
  final String email;
  final String password;

  const RegisterFormState({
    this.formStatus = FormStatus.invalid,
    this.isValid = false,
    // Recordemos que el pure establece el valor por defecto
    this.username = const Username.pure(),
    this.email = '',
    this.password = '',
  });

  RegisterFormState copyWith(
          {FormStatus? formStatus,
          bool? isValid,
          Username? username,
          String? email,
          String? password}) =>
      RegisterFormState(
        formStatus: formStatus ?? this.formStatus,
        isValid: isValid ?? this.isValid,
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  // NOTA: Campos a validar con Equatable
  @override
  List<Object?> get props => [formStatus, isValid, username, email, password];
}
