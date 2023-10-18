// Provider

import 'package:flutter/material.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/domain/repositories/video_posts_repository.dart';

class DiscoverProvider extends ChangeNotifier {
  // NOTA: Acá no quiero tener la implementación de mis videos loscales y vamos a terminar removiendo la implementación que teníamos acá
  //       y para removerlo hacemos lo siguiente:
  final VideoPostRepository videosRepository;

  // NOTA: Creamos una bandera booleana para suponer que cuando cargo la aplicación no voy a tener ningún video
  bool initialLoading = true;

  List<VideoPost> videos = [];

  // Constructor
  DiscoverProvider({
    required this.videosRepository,
  });

  // NOTA: Aunque solo tengamos una página igual quiero usar esta función para cargar los videos.
  Future<void> loadNextPage() async {
    // NOTA: Ahora un problema que deberíamos de empezar a ver es que cuando yo empiece y si hago toda la implementación de la función de cargar los videos en este punto, eso va a amarrar a mi provider a la dependencia del origien
    //       de datos que va a ser local que es el origne de datos que tenemos en share/data/local_video_posts.dart y al día de mañana cuando yo diga no ya no voy a ocupar nada de eso, entonces voy a tener que venir al discover_provider
    //       y hacer las modificaciones respectivas para cargar de un datasource diferente o una funete de datos diferente.
    //       Pero esto es algo que vamos a terminar resolviendo más adelante ya que si no lo hacemos vamos a violentar varios principios SOLID, uno de ellos sería el Open and Closed que dice que nuestras funciones, clases tienen que estar
    //       abiertas a la extensión pero cerradas a la modificación y para lograr esto nosotros deberíamos de poder recibir alguna función, algún tipo de repositorio, es decir, recibir un objeto en el cual yo sepa o ese objeto sepa como
    //       y de donde cargar esos videos. Por lo tanto a este provider no le debería de importar de donde voy a cargar esos videos, al provider simplemente le debería de importar OK necesito llamar esta función para cargar los videos
    //       del lugar u origen de datos que yo especifique.

    final newVideos = await videosRepository.getTrendingVideosByPage(1);

    // NOTA: Agregamos los videos a la lista
    videos.addAll(newVideos);

    // NOTA: Cambiamos la bandera una vez cargados los videos
    initialLoading = false;

    // Notificamos del cambio de estado para que se renderice nuevamente.
    notifyListeners();
  }
}
