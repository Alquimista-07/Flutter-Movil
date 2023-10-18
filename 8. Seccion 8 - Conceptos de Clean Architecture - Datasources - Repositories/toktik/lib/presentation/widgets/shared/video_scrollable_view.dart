// NOTA: Reproductor de video scroleable

import 'package:flutter/material.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/presentation/widgets/shared/video_buttons.dart';
import 'package:toktik/presentation/widgets/video/fullscreen_player.dart';

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
    //       este asignando y es bien útil.
    //       Ahora como no queremos que todos los videos sean constuidos de una vez ya que podemos tener 1000 o 2000 videos o más
    //       esto puede relentizar la aplicación por lo tanto necesitamos que sean construidos a demanda entonces para resolver
    //       esto usamos el método builder.
    return PageView.builder(
      // NOTA: Medianto el ScrollDirection indicamos que queremos un Scroll Vertical ya que por defecto es horizontal
      scrollDirection: Axis.vertical,
      // NOTA: La propiedad physics nos sirve para habilitar en Android el comportamiento por
      //       por defecto en el cual cuando se intenta hacer Scroll y ya esta en el topo hace
      //       un efecto como de rebote
      physics: const BouncingScrollPhysics(),
      itemCount: videos.length,
      itemBuilder: (context, index) {
        // NOTA: Referencia a la instancia de VideoPost
        final VideoPost videoPost = videos[index];

        // NOTA: Ahora necesitamos usar o crear un Stack, explicado en la hoja de atajos. Y este lo usamos porque
        //       colocar hijos (widgets) unos sobre otros que es exáctamente lo que ncesitamos y con esto básicamente
        //       podemos alnearlos en la pantalla en relación al widget padre, entreo otras cosas. Esto porque el video
        //       va a estar de fondo, luego sobre este va a haber un widget que permite colocar un efecto traslucido
        //       porque las letras blancas no se van a ver en fondo blanco y sobre este otro colocar el widget con los
        //       botones, entonces son 3 widgets (video, gradiente y botones).
        //       Otra cosa es que el Stack widget es similar al widget Column
        return Stack(
          children: [
            // Video Player + gradiente
            // NOTA: La propiedad expand obliga a que el video se vea en pantalla completa ya que puede ser que en algunos casos no sea necesario
            //       pero otras veces no, por lo tanto lo obligamos
            SizedBox.expand(
                child: FullScreenPlayer(
              caption: videoPost.caption,
              videoUrl: videoPost.videoUrl,
            )),

            // Botones
            // NOTA: Usamos el widget Positioned para cambiar la posición y colcoarlo donde queremos
            Positioned(
              bottom: 40,
              right: 20,
              child: VideoButtons(video: videoPost),
            )
          ],
        );
      },
    );
  }
}
