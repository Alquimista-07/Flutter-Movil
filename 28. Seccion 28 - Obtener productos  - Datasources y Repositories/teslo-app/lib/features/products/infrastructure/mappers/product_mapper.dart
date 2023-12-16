import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';

class ProductMapper {
  static jsonToEntity(Map<String, dynamic> json) => Product(
        id: json['id'],
        title: json['title'],
        price: double.parse(json['price'].toString()),
        description: json['description'],
        slug: json['slug'],
        stock: json['stock'],
        sizes: List<String>.from(json['sizes'].map((size) => size)),
        gender: json['gender'],
        tags: List<String>.from(json['tags'].map((tag) => tag)),
        // NOTA: Para las imagenes tenemos dos tipos, unas con un nombre parcial y otras que tienen el url completo, entonces tenemos que hacerles un tratamiento diferente
        //       y esto depende de como este el backend ya que en este caso el backend trabaja de esa manera.
        images: List<String>.from(
          json['images'].map(
            (String image) => image.startsWith('http')
                ? image
                : '${Environment.apiUrl}/files/product/$image',
          ),
        ),
        user: UserMapper.userJsonToEntity(json['user']),
      );
}
