//NOTA: Formz nos va a ayudar a tener centralizado nuestras validaciones y unos tipos específicos de datos como los Input
//      y a su vez agregarle lo relacionado a ese Input como por ejemplo los errores personalizados de dicho Input.
//
//      Este paquete es necesario instalarlo y su documentación la encontramos en: https://pub.dev/packages/formz
//
//      Adicionalmente al ser un paquete este nos va a ayudar con la creación y validación de los formularios.

import 'package:formz/formz.dart';

// Define input validation errors.
// NOTA: OJO yo mismo defino esta enumeración.
enum UsernameError { empty, lenght }

// Extend FormzInput and provide the input type and error type.
class Username extends FormzInput<String, UsernameError> {
  // Call super.pure to represent an unmodified form input.
  // NOTA: Llamada al super para establecer un valor inicial
  const Username.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  // NOTA: La forma como quiero que cambie el valor que puede ser posicionales o por nombre, a manera personal en este caso para formularios
  //       es mejor mandarlo posicional obligatorio.
  //       Adicionalmente la forma de llamar el disty es básicamente decirl Hey! el campo esta cambió y ya fue manipulado por el usuario.
  const Username.dirty(String value) : super.dirty(value);

  // Override validator to handle validating a given input value.
  // NOTA: Regresa un opcional ya que puede ser que no tenga errores
  @override
  UsernameError? validator(String value) {
    // NOTA: Establecemos la forma como van a ser nuestras validaciones
    //       OJO. Recordemos que el trim es para quitar los espacios al inicio y fin de la cadena de texto.
    if (value.isEmpty || value.trim().isEmpty) return UsernameError.empty;
    if (value.length < 6) return UsernameError.lenght;

    return null;
  }
}
