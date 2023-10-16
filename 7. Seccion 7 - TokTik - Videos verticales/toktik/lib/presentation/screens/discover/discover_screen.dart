import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktik/presentation/providers/discover_provider.dart';
import 'package:toktik/presentation/widgets/shared/video_scrollable_view.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // NOTA: Obtenemos la referencia al provider. Y necesitamos estar pendientes si hay nuevos videos entonces usamos el watch
    //       para que renderice el widget cuando se ingresen nuevos videos ya que necesitamos volverlos a redibujar.
    //
    //       Otra cosa que tenemos que tener en cuanta es que cuando usamos el read vamos a estar escuchando sin que renderice el
    //       widget en caso de que hayan cambios
    final discoverProvider = context.watch<DiscoverProvider>();

    // NOTA: Las dos siguiente líneas de código son exáctemente la misma solo que una es más larga que la otra pero en si hacen lo mismo
    /*
    final discoverProvider = context.read<DiscoverProvider>();
    final otroProvider = Provider.of<DiscoverProvider>(context, listen: false);
    */
    return Scaffold(
        body: discoverProvider.initialLoading
            // NOTA: Si aun esta cargando mostramos un loader
            ? const Center(
                child:
                    // NOTA: La propiedad strokeWidth indica el grosor de la línea del loader
                    CircularProgressIndicator(
                strokeWidth: 2,
              ))
            // NOTA: Cuando ya cargo mostramos el video a partir de un widger personalizado
            : VideoScrollableView(videos: discoverProvider.videos));
  }
}
