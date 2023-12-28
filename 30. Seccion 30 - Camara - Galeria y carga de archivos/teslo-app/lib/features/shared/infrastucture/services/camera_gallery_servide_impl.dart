// NOTA: El enlace a la documentación del paquete image_picker y el cual usamos para la gestion de cámara y galería lo encontramos en el
//       siguiente enlace: https://pub.dev/packages/image_picker
// NOTA: Acá vamos a tener nuestra implementación que debe cumplir con la firma que definimos en nuestra
//       clase abstracta CameraGalleryService
import 'package:image_picker/image_picker.dart';

import 'camera_galery_service.dart';

class CameraGalleryServiceImpl extends CameraGalleryService {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<String?> selectPhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (photo == null) return null;

    print('Tenemos una imágen: ${photo.path}');

    return photo.path;
  }

  @override
  Future<String?> takePhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
      // NOTA: Cámara tracera o principal por defecto
      preferredCameraDevice: CameraDevice.rear,
    );

    if (photo == null) return null;

    print('Tenemos una imágen: ${photo.path}');

    return photo.path;
  }
}
