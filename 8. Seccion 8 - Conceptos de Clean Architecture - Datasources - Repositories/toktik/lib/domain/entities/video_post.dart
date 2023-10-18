// NOTA: Esta clase es para definir como va a lucir nuestros data, es decir va a ser el modelo de dato que nosotros tendríamos
//       bien cercano a las reglas de negocio de la institución y seria como queremos que la data fluya en genera en nuestra
//       aplicación sin importar de las fuentes externas.
class VideoPost {
  // Propiedades
  final String caption;
  final String videoUrl;
  final int likes;
  final int views;

  // Constructor
  VideoPost({
    required this.caption,
    required this.videoUrl,
    this.likes = 0,
    this.views = 0,
  });
}
