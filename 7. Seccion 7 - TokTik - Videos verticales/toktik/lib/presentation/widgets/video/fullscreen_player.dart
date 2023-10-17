import 'package:flutter/material.dart';

// NOTA: Para realizar este widget fue basado en la documentación y tutorial oficial de Flutter tomado de:
//       https://docs.flutter.dev/cookbook/plugins/play-video y hay que tener esto presente ya que si el día
//       de mañana queremos colocar por ejemplo videos desde una url en Android o IOS hay que tener en cuenta
//       algunas cosas como el protocolo y permisos que hay que agregar para que funcione y de hecho si agregamos
//       uno de esos permisos para Android en este caso y que va en el AndroidManifest.xml en el directorio
//       /android/app/src/main/

class FullScreenPlayer extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
