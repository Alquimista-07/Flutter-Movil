import 'package:flutter/material.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class HerMessageBubble extends StatelessWidget {
  // NOTA: Creamos la propiedad para el mensaje
  final Message message;
  // Constructor
  const HerMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    // NOTA: Ahora pedimos que busque el tema del contexto y como nuestro contexto global le estamos asignando los colores
    //       en nuestra clase personalizada para esto va a cambiar los colores de forma automática cada vez que cambiemos
    //       el tema en la app.
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              // NOTA: Asignamos el color tomado a partir de nuestro contexto global.
              color: colors.secondary,
              // NOTA: Hacemos redondos el boxDecoration.
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              // NOTA: Cambiamos el texto harcodeado y obtenemos el texto directamente del entity message y que proviene desde el Provider creado en el widget padre llamado chat_screen
              message.text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        // NOTA: Agregamos una separación entre cada BoxDecoration y el cual es un widget que usamos anteriormente y se había explicado su funcionamiento
        const SizedBox(height: 5),

        // Usamos el widget que creamos para mostrar la imágen.
        // NOTA: El símbolo ! significa not null asertion y con el cual le indicamos que a pesar de que la propiedad es opcional siempre la vamos a recibir
        //       y esto lo sabemos porque siempre el api nos responde con la imagen.
        _ImageBubble(message.imageUrl!),
        const SizedBox(height: 10)
      ],
    );
  }
}

// Widget para mostrar la imágen
class _ImageBubble extends StatelessWidget {
  // NOTA: Creamos la propiedad para la imágen
  final String imageUrl;

  // Constructor poscional. OJO recordemos que para que sea por nombre tiene que llevar {} y sin el required en las propiedade
  const _ImageBubble(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    // NOTA: Como quiero que la imágen ocupe un cirto porcentaje de la pantalla, lo que puedo hacer e obtener las dimensiones del dispositivo
    //       para asginar el porcentaje de forma correcta.
    //       Entonces el MediaQuery nos va a dar la información referente al dispositivo que la esta ejecutando, el context hace referencia al
    //       árbol de widgets y entre ese montón de información que está en ese árbol de widgets también están las dimensiones y diferentes
    //       características del dispositivo que lo esta corriendo
    final size = MediaQuery.of(context).size;

    // NOTA: EL widget ClipRRect nos permite hacer bordes redondeados
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        // NOTA: Colocamos la imágen que nos trae desde la api
        imageUrl,
        width: size.width * 0.7, // 70% del tamaño
        // NOTA: EL objetivo de dejar un height específico es porque no quiero que las imágenes siempre se desproporcionen
        //       y evitar brincos inesperados en el diseño
        height: 150,
        fit: BoxFit
            .fill, // Para que los bordes se acoten correctamente hacemos este BoxFit ya que si no se colcoa se vana ver las imágenes cuadradas
        // NOTA: Tenemos esta otra propiedad llamada loadingBuilder la cual nos permite mostrar algo mientras se carga la imágen ya que si nos damos cuenta hay un lapso de tiempo en que no aparece nada mientras
        //       se trae la imágen de internet. Adicionalmente recordemos que cuando vemos la palabra builder es algo que se va a construir en tiempo de ejecución.
        //        Y algual que el itemBuilder que usamos en el chat_screen este también puede usar una función que podemos especificar de dos formas, una función flecha que regresa implícitamente un widget o una
        //        función con cuerpo. Acá tenemos nuestro BuildContext, el child que básicamente es la imágen, y el loadingProgress
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null)
            return child; // El progreso se completo y la imágen ya se cargo entonces regresamos la imágen

          // Aún no se ha cargado regresamos un widget con algo
          return Container(
            width: size.width * 0.7,
            height: 150,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: const Text('Mi amor está enviando un mensaje'),
          );
        },
      ),
    );
  }
}
