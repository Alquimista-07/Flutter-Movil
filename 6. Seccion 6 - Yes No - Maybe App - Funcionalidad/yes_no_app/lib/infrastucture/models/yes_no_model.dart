// NOTA: El objetivo de esta clase es crear un Mapper que me va a servir para mapear la data, es decir, tener todas
//       las propiedades que bienen de la respuesta del api o del backend, esto nos va a permitir primero usar la notación
//       de punto y no de llaves, y también para que  centralicemos como se va a dar la data en un solo lugar y si el día
//       de mañana algo cambia en la respuesta podamos fácilmente hacer el cambio en un solo lugar y no afectar el resto de
//       la aplicación ya que si la tenemos con notación de llaves en varios lugares esto causaria posibles fallos o que el
//       en cuando a si nos equivamos escribiendo o en cuanto al mantenimiento. Y esto de manejar los mappers o modelos son
//       buenas prácticas.
// NOTA: Adicionalmente todo este código lo podemos generar a través de QuickType que veces anteriores lo hemos usado con el
//       curso de Angular el cual a través de la respuesta que nos da por ejemplo postman de la petición podemos tomarla
//       pegarla y genrar todo este código de acá.

import 'package:yes_no_app/domain/entities/message.dart';

class YesNoModel {
  // Atributos
  final String answer;
  final bool forced;
  final String image;

  // Constructor
  YesNoModel({required this.answer, required this.forced, required this.image});

  // NOTA: Creamos un factory constructor
  //       EL factory es básicamente es porque yo quiero a la larga que cuando alguien llame este constructor con nombre va a
  //       terminar creando una nueva instancia que yo necesito, en este caso una instancia de YesNoModel
  factory YesNoModel.fromJsonMap(Map<String, dynamic> json) => YesNoModel(
      answer: json["answer"], forced: json["forced"], image: json["image"]);

  Map<String, dynamic> toJson() => {
        "answer": answer,
        "forced": forced,
        "image": image,
      };

  // NOTA: Ahora con esto acá puedo crearme un método que me va a permitir crearme una instancia de mi mensaje.
  //       Y este mapper es el que realmente voy a usar y ya no ocupamos el código que teníamos anteriormete en
  //       el return del get_yes_no_answer.dart
  Message toMessageEntity() => Message(
      text: answer == 'yes' ? 'Si' : 'No',
      fromWho: FromWho.hers,
      imageUrl: image);
}
