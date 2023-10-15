// NOTA: Acá vamos a tener el código para realizar peticiones http, lo vamos a hacer con una clase ya que se quieren establecer
//       varias cosas pero fácilmente lo podríamos hacer con una función

import 'package:dio/dio.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/infrastucture/models/yes_no_model.dart';

class GetYesNoAnswer {
  // NOTA: Hay varias formas de hacer la petición HTTP, se puede hacer con Dart directamente pero hay mucho código involucrado para
  //       lograrlo y usalmente vamos a terminar usando uno de dos paquetes. Entonces nos vamos a pub.dev y uno de los paquetes más
  //       populares es http, otro paquete que es muy pero muy usado es dio y con este se instalan menos dependencias que con http y
  //       por eso mucha gente lo prefiere usar y también es más ligero y por lo tanto dio es el que vamos a usar.
  //       Ahora para usar dio es aún más fácil en algunos conceptos ya que dio hace la serialización del mapa por nosotros
  //       y dio también sirve para hacer descargas, en general dio es muy poderoso.
  //       También a la instancia de Dio le podemos mandar las baseOptions como la baseUrl si queremos que todas las peticiones pasen
  //       por ahí, los header, method, queryParameters por defecto, etc. Por esto es muy muy poderoso este paquete.

  final _dio = Dio();

  // NOTA: Vamor a retornar una nueva instancia de un nuevo mensaje y por lo tanto no necesito argumentos en la función
  Future<Message> getAnswer() async {
    final response = await _dio.get('https://yesno.wtf/api');

    // NOTA: Ya con el mapper o modelo podemos usar la notación de punto
    final yesNoModel = YesNoModel.fromJsonMap(response.data);

    // NOTA: Esto lo quite ya que el mapper lo tengo en el model
    //return Message(
    //    text: yesNoModel.answer,
    //    fromWho: FromWho.hers,
    //    imageUrl: yesNoModel.image);

    // NOTA: Usamos nuestro nuevo mapper
    return yesNoModel.toMessageEntity();
  }
}
