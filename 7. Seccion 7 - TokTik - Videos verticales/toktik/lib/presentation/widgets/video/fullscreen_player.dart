import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// NOTA: Para realizar este widget fue basado en la documentación y tutorial oficial de Flutter tomado de:
//       https://docs.flutter.dev/cookbook/plugins/play-video y hay que tener esto presente ya que si el día
//       de mañana queremos colocar por ejemplo videos desde una url en Android o IOS hay que tener en cuenta
//       algunas cosas como el protocolo y permisos que hay que agregar para que funcione y de hecho si agregamos
//       uno de esos permisos para Android en este caso y que va en el AndroidManifest.xml en el directorio
//       /android/app/src/main/

class FullScreenPlayer extends StatefulWidget {
  // NOTA: Como queremos que el widget sea reutilizable y de uso general y que no solo recibamos el video de videoPost
  //       para implementarlo sino que también podamos recibir una url por si lo queremos usar el día de mañana para otra
  //       cosa y no tener que implementar todo con videoPost incluidos, entonces vamos a definir ciertas propiedades
  final String videoUrl;
  final String caption;

  const FullScreenPlayer({
    super.key,
    required this.videoUrl,
    required this.caption,
  });

  @override
  State<FullScreenPlayer> createState() => _FullScreenPlayerState();
}

class _FullScreenPlayerState extends State<FullScreenPlayer> {
  late VideoPlayerController controller;

  @override
  void initState() {
    // NOTA: El super.initiState va al inicio
    super.initState();
    // NOTA: Para hacer refetencia a las propiedades dentro dl state podemos usar la palabra widget y luego con la notiación de punto
    //       ya nos damos cuenta que tenenos acceso a las propiedades.
    controller = VideoPlayerController.asset(widget.videoUrl)
      // NOTA: Usando el operador de cascada llamamos otro método que lo que hace es quitar el volumen del video
      ..setVolume(0)
      // NOTA: Nuevamente usamos el operador de cascada para usar el método que hace el loop del video y se siga reproduciendo tal cual como lo hace TikTok o KWai;
      ..setLooping(true)
      // NOTA: Otra vez con el operador de casdada definimos para que inmediatamente se le de play al video
      ..play();
  }

  // NOTA: Al ser un Statefull widget este si tiene Ciclo de vida a diferencia del Stateless Widget que se crea y luego nuevamente se crea y así sucesivamente,
  //       entonces el Statfull al tener ciclo de vida necesitamos que limpiarlo y si se destruye ya que el PageView va a estar construyendolo y destruyendolo
  //       vamos a tener que limpiar y para esto usamos el método dispose con el fin de que el video ya no se siga reproduciendo a pesar de que no lo estemos viendo
  @override
  void dispose() {
    // Acá hacemos la limpieza con el fin de que el video no se siga reproduciendo a pesar de que ya no lo estemos viendo u otro tipo de fuga de memoria.
    controller.dispose();

    // NOTA: El super.dispose va al final
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.initialize(),
      builder: (context, snapshot) {
        // NOTA: Validamos con el future el paso de inicialización del video y mostrar el indicador del progreso cuando aún no este listo
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
              // NOTA: Colocamos el indicador de progreso, con su respectivo tamaño de línea y le ponemos un color
              child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.deepPurple,
          ));
        }

        // NOTA: Cuando ya este listo reproducimos el video.
        //       Adicionalmente envolvemos el AspectRatio en un GestureDetector para detectar los gestos de la pantalla y de esta forma poder pausar y reporducir
        //       el video al tocar la pantalla
        return GestureDetector(
          onTap: () {
            if (controller.value.isPlaying) {
              controller.pause();
              return;
            }
            controller.play();
          },
          child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: Stack(
              children: [
                VideoPlayer(controller),

                // Gradiente: Contrastar para que el texto blanco se vea bien en videos con fondo claro.

                // Texto
                Positioned(
                    bottom: 50,
                    left: 20,
                    child: _VideoCaption(
                      caption: widget.caption,
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}

class _VideoCaption extends StatelessWidget {
  final String caption;

  const _VideoCaption({
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    // Referencia al tamaño de la pantalla
    final size = MediaQuery.of(context).size;

    // Tomamos el estilo del tema global
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return SizedBox(
        width: size.width * 0.6, // 60%
        child: Text(
          caption,
          maxLines: 2,
          style: titleStyle,
        ));
  }
}
