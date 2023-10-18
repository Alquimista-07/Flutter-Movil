import 'package:toktik/domain/entities/video_post.dart';

class LocalVideoModel {
  final String name;
  final String videoUrl;
  final int likes;
  final int views;

  LocalVideoModel(
      {required this.name,
      required this.videoUrl,
      this.likes = 0,
      this.views = 0});

// NOTA: Cramos el factory constructor y a algunas propieades del mismo le asignamos un valor por defecto si no viene, recordemos que para
//       asignar el valor por defecto es usando ?? y luego el valor. Adicionalmente con este factory constructor estamos creando la nueva
//       instancia del LocalVideoModel cuando recibimos el JSON Object de la respuesta http
  factory LocalVideoModel.fromJsonMap(Map<String, dynamic> json) =>
      LocalVideoModel(
          name: json['name'] ?? 'No name',
          videoUrl: json['videoUrl'],
          likes: json['likes'] ?? 0,
          views: json['views'] ?? 0);

// NOTA: Creamos el método mapper para mapear los campos
  VideoPost videoPostEntity() => VideoPost(
        // NOTA: Acá recordemos que podemoa usar el this. para los campos por ejemplo this.name pero recordemos que estamos dentro de la misma
        //       clase y por lo tanto no es necesario, adicionalmente el editor nos dice en un warning que eso es innecesario y que lo quitemos.
        caption: name,
        videoUrl: videoUrl,
        likes: likes,
        views: views,
      );
}
