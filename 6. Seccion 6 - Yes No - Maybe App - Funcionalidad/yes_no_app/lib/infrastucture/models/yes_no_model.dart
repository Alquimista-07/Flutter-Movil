// NOTA: El objetivo de esta clase es crear un Mapper que me va a servir para mapear la data, es decir, tener todas
//       las propiedades que bienen de la respuesta del api o del backend, esto nos va a permitir primero usar la notación
//       de punto y no de llaves, y también para que  centralicemos como se va a dar la data en un solo lugar y si el día
//       de mañana algo cambia en la respuesta podamos fácilmente hacer el cambio en un solo lugar y no afectar el resto de
//       la aplicación ya que si la tenemos con notación de llaves en varios lugares esto causaria posibles fallos o que el
//       en cuando a si nos equivamos escribiendo o en cuanto al mantenimiento. Y esto de manejar los mappers o modelos son
//       buenas prácticas
import 'dart:convert';

class YesNoModel {
  // Atributos
  String answer;
  bool forced;
  String image;

  // Constructor
  YesNoModel({required this.answer, required this.forced, required this.image});

  // NOTA: Creamos un factory constructor
  //       EL factory es básicamente es porque yo quiero a la larga que cuando alguien llame este constructor con nombre va a
  //       terminar creando una nueva instancia que yo necesito, en este caso una instancia de YesNoModel
  factory YesNoModel.fromJsonMap(Map<String, dynamic> json) => YesNoModel(
      answer: json['answer'], forced: json['forced'], image: json['image']);
}
