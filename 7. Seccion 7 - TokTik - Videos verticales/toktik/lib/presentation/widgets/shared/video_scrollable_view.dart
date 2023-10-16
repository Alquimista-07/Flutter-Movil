// NOTA: Reproductor de video scroleable

import 'package:flutter/material.dart';
import 'package:toktik/domain/entities/video_post.dart';

class VideoScrollableView extends StatelessWidget {
  final List<VideoPost> videos;

  const VideoScrollableView({
    super.key,
    required this.videos,
  });

  @override
  Widget build(BuildContext context) {
    // NOTA: EL PageView es similar al ListView que usamos antesriormente en el chat
    //       y básicamente es un widget que nos permite hacer un scroll a pantalla completa
    //       por lo tanto el PageView toma toda la pantalla o el espacio disponible que se
    //       este asignando y es bien útil
    return PageView(
      // NOTA: Medianto el ScrollDirection indicamos que queremos un Scroll Vertical ya que por defecto es horizontal
      scrollDirection: Axis.vertical,
      // NOTA: La propiedad physics nos sirve para habilitar en Android el comportamiento por
      //       por defecto en el cual cuando se intenta hacer Scroll y ya esta en el topo hace
      //       un efecto como de rebote
      physics: const BouncingScrollPhysics(),
      children: [
        Container(
          color: Colors.red,
        ),
        Container(
          color: Colors.blue,
        ),
        Container(
          color: Colors.green,
        ),
        Container(
          color: Colors.teal,
        ),
        Container(
          color: Colors.yellow,
        )
      ],
    );
  }
}
