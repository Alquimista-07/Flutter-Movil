// NOTA: Origen de datos de videos locales, pero podríamos tener una implementacción para videos desde la web y otros origenes de datos

import 'package:toktik/domain/datasources/video_posts_datasource.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/infrastucture/models/local_video_model.dart';
import 'package:toktik/shared/data/local_video_posts.dart';

// NOTA: Ahora acá podemos estender o implementar y cualquiera de las dos es válida y la diferencia entre una y otra
//       se meciono en la sección 2 de introducción a dart
class LocalVideoDatsource implements VideoPostDatsource {
  @override
  Future<List<VideoPost>> getFavoriteVideosByUser(String userID) {
    throw UnimplementedError();
  }

  // NOTA: Hacemos la implementación de mis videos locales y cuando tengamos en la web acá vamos a poder cambiar eso.
  @override
  Future<List<VideoPost>> getTrendingVideosByPage(int page) async {
    // Simulamos una petición http asíncrona
    await Future.delayed(const Duration(seconds: 2));

    // NOTA: El método map del List es similar al que usamos en JavaScript y sirve para barrer cada uno de los elementos dentro del listado y lo que
    //       sea que regrese es lo que voy a retornar que va a ser un iterable por lo tanto no es literalmente un listado después y recordemos lo que
    //       vimos en la introducción de dart en la sección 2.
    //       Entonces cargamos los videos a una lista
    final List<VideoPost> newVideos = videoPosts
        .map((video) => LocalVideoModel.fromJsonMap(video).videoPostEntity())
        .toList();

    return newVideos;
  }
}
