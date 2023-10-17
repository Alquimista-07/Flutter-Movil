import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:toktik/config/helpers/human_formats.dart';
import 'package:toktik/domain/entities/video_post.dart';

class VideoButtons extends StatelessWidget {
  // Recibimos el video porque necesito tener la referencia a los likes y views
  final VideoPost video;

  const VideoButtons({
    super.key,
    required this.video,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CustomIconButton(
          value: video.likes,
          iconColor: Colors.red,
          iconData: Icons.favorite,
        ),
        const SizedBox(height: 20),
        _CustomIconButton(
          value: video.views,
          iconData: Icons.remove_red_eye_outlined,
        ),
        const SizedBox(height: 20),
        // NOTA: Para agregar la animación del ícono vamos a usar un paquete llamato animate_do creado por Fernando Herrera y basado o instpirado en las animaciones de AnimatedCss
        //       y el cual nos ofrece una amplia gama de animaciones fáciles de implementar ya que como tal hacer animaciones lineales el flutter no es tan complicado pero si queremos hacer
        //       algo más elaborado como en este caso que el ícono gire si ya se ocupan hacer y usar otros widgets y demás cosas lo cual incrementa la complejidad pero ya con este paquete que nos
        //       da Fernando podemos implementar fácilmente ese tipo de animaciones. Ademád de que él le sigue dando soporte y ya es compatible con Dart 3. Entonces tenemos algunas animaciones
        //       como el BounceInDown, o el SpinPefect que es el que vamos a usar.
        SpinPerfect(
          infinite: true,
          duration: const Duration(seconds: 5),
          child: const _CustomIconButton(
            value: 0,
            iconData: Icons.play_circle_outlined,
          ),
        )
      ],
    );
  }
}

class _CustomIconButton extends StatelessWidget {
  final int value;
  final IconData iconData;
  final Color? color;

  const _CustomIconButton({
    required this.value,
    required this.iconData,
    iconColor,
  }) : color = iconColor ?? Colors.white;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              iconData,
              color: color,
              size: 30,
            )),
        if (value > 0) Text(HumanFormats.humanReadbleNumber(value.toDouble())),
      ],
    );
  }
}
