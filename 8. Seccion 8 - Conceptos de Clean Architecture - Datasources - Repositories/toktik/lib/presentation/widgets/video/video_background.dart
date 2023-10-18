import 'package:flutter/material.dart';

class VideoBackground extends StatelessWidget {
  final List<Color> colors;
  final List<double> stops;

  const VideoBackground({
    super.key,
    this.colors = const [
      Colors.transparent,
      Colors.black87,
    ],
    this.stops = const [0.0, 1.0],
  }) : assert(colors.length == stops.length,
            'Stops and Colors must be same lenght');

  @override
  Widget build(BuildContext context) {
    // NOTA: El fill es similar a un sizebox pero como va a estar dentro de un Stack básicamente le va a decir
    //       que tome todo el espacio posible del stack.
    return Positioned.fill(
      child: DecoratedBox(
          decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          // NOTA: Posición del gradiente otra cosa es que tienen que ser igual a la canitdad de colores
          stops: stops,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      )),
    );
  }
}
