// NOTA: De la misma forma que realizamos para crear la clase envoltorio que creamos para almacenar
//       el token en el almacenamiento local del dispositivo. Acá también vamos a usar ese patrón
//       adaptador para crear el servicio que se va a encargar la gestión de la galeria y la cámara
//       Este patron lo implementamos para que de la misma forma que sucede con el almacenamiento del
//       token para que si el día de mañana queremos hacer cambios o usar otro paquete sea de forma más
//       sencilla y no impacte la aplicación.

// NOTA: El enlace a la documentación del paquete image_picker y el cual usamos para la gestion de cámara y galería lo encontramos en el
//       siguiente enlace: https://pub.dev/packages/image_picker

// NOTA: Y la razón por la que creo esta clase como abstracta es porque quiero que al día de mañana si se quiere
//       cambiar la implementación, entonces se va a tener que cumplir con esta firma o reglas.
abstract class CameraGalleryService {
  // Esta función nos va a regresar el String opcional con el path físico donde esta la fotografía que acabamos de
  // tomar
  Future<String?> takePhoto();

  Future<String?> selectPhoto();
}
