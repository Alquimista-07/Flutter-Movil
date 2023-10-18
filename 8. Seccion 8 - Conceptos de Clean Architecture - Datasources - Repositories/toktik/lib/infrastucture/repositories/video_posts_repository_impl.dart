// NOTA: OJO notemos que el nombre del archivo no tiene la palabra local o http o JSON, sino simplemente lo estoy
//       llamando video_posts_repository_impl.dart

// NOTA: Ahora acá podemos estender o implementar y cualquiera de las dos es válida y la diferencia entre una y otra
//       se meciono en la sección 2 de introducción a dart
import 'package:toktik/domain/datasources/video_posts_datasource.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/domain/repositories/video_posts_repository.dart';

class VideoPostsRepository implements VideoPostRepository {
  // NOTA: Acá viene lo interesante, entonces este VideoPostsRepository necesita el VideoPostDatasource, y no es la implementación
  //       necesita una fuente de origen de datos, y notemos que estamos usando la clase abstacta no la implementación. Y al hacerlo
  //       de esta manera quiere decir que cualquier datasource es permitido, locales, web, JSON, etc.
  final VideoPostDatsource videosDatasource;

  // Constructor
  VideoPostsRepository({
    required this.videosDatasource,
  });

  @override
  Future<List<VideoPost>> getFavoriteVideosByUser(String userID) {
    throw UnimplementedError();
  }

  // Implementación y eso es todo lo que se hace nada más.
  @override
  Future<List<VideoPost>> getTrendingVideosByPage(int page) {
    return videosDatasource.getTrendingVideosByPage(page);
  }
}
