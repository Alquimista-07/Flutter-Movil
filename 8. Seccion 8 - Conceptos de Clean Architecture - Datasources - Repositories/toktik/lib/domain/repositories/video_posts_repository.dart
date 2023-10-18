// NOTA: La razón del proque la creamos abstracta es porque no quiero que se creen instancias de esta
//       Adicionalmente las clases que implementen o extiendan esta clase abstracta van a ser datsources
//       (orignes de datos) válidos y permitidos par que mis providers o repositorios(forma en como accedo
//       a la información) que son los que realmente terminan llamando los datasources puedan obtener esa
//       información que desean.
import 'package:toktik/domain/entities/video_post.dart';

// NOTA IMPORTANTE: Si nos fijamos el reporsitory y el datasource son prácticamente iguales y solo cambia el nombre de la clase,
//                  pero porque son iguales, porque la idea es que el repository va a terminar llamando al datasource. Y el porque de no llamar
//                  el datasource de forma directa es porque nosotros deberiamos fácilmente poder hacer el cambio del origne de datos y en
//                  nuestras clases simplemente mandar a llamar el repositorio de getFavoriteVideosByUser o getTrendingVideosByPage sin importar
//                  el datasource(fuente de datos) y esto es porque a quien se a que llame el repositorio no le va a interesar cual es el origen
//                  de datos, simplemente llamalos y quiero la respuesta yo soy quien le va a decir de donde los va a tomar.
//                  Por lo tanto si tenemos nuestro repositoiro el repositorio es quien va a llamar al datasource y de esa manera nosotros podemos
//                  cambiar un datasource por otro datasource y otro y otro y así sucesivamente pero todas las demás partes de nuestra aplicación
//                  va a quedar literalmente igual y vamos a poder cambiar origenes de datos en cualquier momento sin tener que cambiar las
//                  implementaciones en nuestras clases y ese es el objetivo principal de esto que estamos hacidneo de crear datsources y reposities.
//
//                  Entonces estas clases abstractas solo las hemos definido para que gobiernen lo que van a ser las clases que nosotros vamos a crear
//                  y que van a ser las implementaciones de esas clases abstractas que son las que realmente vamos a terminar usando, pero al ponerle
//                  estas reglas nosotros podemos aplicar nuevamente otros principios para poder tomar las clases padre como referencia y así fácilmente
//                  vampos a permitir hacer el cambio y todavía tener todo el tipado estrícto para tener un desarrollo que va a ser fácil de ,antener y
//                  actualizar a un futuro.

abstract class VideoPostRepository {
  // NOTA: Ojo notemos que no la estamos implementando ya que eso no es lo que al datasource le importa,
  //       simplemente le dice tienes que regresar un Future que regresa una lista de video posts y
  //       también va a pedir la página en la cual necesitas cargar esos videos.
  Future<List<VideoPost>> getTrendingVideosByPage(int page);

  // NOTA: Entonces al llamar este método voy a cargar los videos favoritos del usurio y no me importa de donde
  //       vengan esos videos, simplemente yo se que a la hora de llamar este método es problema de quien sea que
  //       implemente esta clase de donde va a obtener esa información.
  Future<List<VideoPost>> getFavoriteVideosByUser(String userID);

  // NOTA: Para que un origen de datos(datasource) yo lo pueda cambiar tiene que implementar al menos estos dos métodos,
  //       puede tener más cosas, si! pero por lo menos debo de tener lo que yo estoy colocando acá, es decir, esas son
  //       mis reglas
}
