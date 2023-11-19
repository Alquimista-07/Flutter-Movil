import 'package:formz/formz.dart';

enum PasswordError { empty, length }

class Password extends FormzInput<String, PasswordError> {
  const Password.pure() : super.pure('');

  const Password.dirty(String value) : super.dirty(value);

  // NOTA: Para el manejo de los mensajes de error vamos a crear un getter
  String? get errorMessage {
    if (isValid || isPure) return null;

    // El displayError es una propiedad propia del paquete Formz que sirve para mostrar el error
    if (displayError == PasswordError.empty) return 'El campo es requerido';
    if (displayError == PasswordError.length) return 'Mínimo 6 caracteres';

    return null;
  }

  @override
  PasswordError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return PasswordError.empty;
    if (value.length < 6) return PasswordError.length;

    return null;
  }
}
