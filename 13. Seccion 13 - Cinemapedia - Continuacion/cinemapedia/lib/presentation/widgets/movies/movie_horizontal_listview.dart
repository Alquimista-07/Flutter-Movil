// NOTA: Este Listview Horizontal lo queremos hacer lo más genérico posible con el fin de poder reutilizarlo
//       en otras secciones de la aplicación, por lo tanto vamnos a recibir propiedades a través de su
//       constructor
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieHorizontalListView extends StatelessWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;

  // NOTA: Adicionalmente voy a ocupar saber cuando llegue al final del slideshow con el fin de cargar más películas
  //       y hacer el inifinte scroll y para ello lo vamos a hacer con un VoidCallback
  final VoidCallback? loadNextPage;

  const MovieHorizontalListView({
    super.key,
    required this.movies,
    this.title,
    this.subTitle,
    this.loadNextPage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if (title != null || subTitle != null)
            _Title(title: title, subTitle: subTitle),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const _Title({
    this.title,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          // Titulo
          if (title != null)
            Text(
              title!,
              style: titleStyle,
            ),
          // NOTA: Agregamos un espacio
          const Spacer(),
          // Subtitulo
          if (subTitle != null)
            FilledButton.tonal(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {},
              child: Text(subTitle!),
            )
        ],
      ),
    );
  }
}
