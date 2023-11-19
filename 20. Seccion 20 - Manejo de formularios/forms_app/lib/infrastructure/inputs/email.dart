import 'package:formz/formz.dart';

enum EmailError { empty, format }

class Email extends FormzInput<String, EmailError> {
  // NOTA: Expresión regular para verificar si tiene formato de correo
  static final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  const Email.pure() : super.pure('');

  const Email.dirty(String value) : super.dirty(value);

  // NOTA: Para el manejo de los mensajes de error vamos a crear un getter
  String? get errorMessage {
    if (isValid || isPure) return null;

    // El displayError es una propiedad propia del paquete Formz que sirve para mostrar el error
    if (displayError == EmailError.empty) return 'El campo es requerido';

    if (displayError == EmailError.format) {
      return 'No tiene formato de correo electrónico';
    }

    return null;
  }

  @override
  EmailError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return EmailError.empty;

    // Acá evaluamos contra la expresión regular
    if (!emailRegExp.hasMatch(value)) return EmailError.format;

    return null;
  }
}
