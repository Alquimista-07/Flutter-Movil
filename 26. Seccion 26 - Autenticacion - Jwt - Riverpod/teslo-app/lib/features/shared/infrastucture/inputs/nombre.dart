import 'package:formz/formz.dart';

enum NombreError { empty, length }

class Nombre extends FormzInput<String, NombreError> {
  const Nombre.pure() : super.pure('');

  const Nombre.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == NombreError.empty) return 'El campo es requerido';
    if (displayError == NombreError.length) return 'Mínimo 6 caracteres';

    return null;
  }

  @override
  NombreError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return NombreError.empty;
    if (value.length < 6) return NombreError.length;

    return null;
  }
}
