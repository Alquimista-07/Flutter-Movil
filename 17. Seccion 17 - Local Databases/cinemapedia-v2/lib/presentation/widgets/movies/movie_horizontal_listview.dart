// NOTA: Este Listview Horizontal lo queremos hacer lo más genérico posible con el fin de poder reutilizarlo
//       en otras secciones de la aplicación, por lo tanto vamnos a recibir propiedades a través de su
//       constructor
import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieHorizontalListView extends StatefulWidget {
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
  State<MovieHorizontalListView> createState() =>
      _MovieHorizontalListViewState();
}

class _MovieHorizontalListViewState extends State<MovieHorizontalListView> {
  // NOTA: Controlador para el scroll infinito
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      // NOTA: Obtenemos la posición actual del scroll con 200 de gracia
      if ((scrollController.position.pixels + 200) >=
          scrollController.position.maxScrollExtent) {
        //print('Load next movies');
        widget.loadNextPage!();
      }
    });
  }

  // NOTA: Recordemos que cada vez que agreguemos un listener tenemos que agregar un dispose para
  //       destruirlo cuando salgamos de la pantalla, esto con el fin de evitar fugas de memoria.
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if (widget.title != null || widget.subTitle != null)
            _Title(title: widget.title, subTitle: widget.subTitle),
          Expanded(
            child: ListView.builder(
              // NOTA: Agregamos el controller
              controller: scrollController,
              itemCount: widget.movies.length,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return FadeInRight(child: _Slide(movie: widget.movies[index]));
              },
            ),
          )
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
    // NOTA: Traemos los estilos del texto de la aplicación
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

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    // NOTA: Traemos los estilos de los textos de la aplicación
    final textStyles = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* Imágen
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  }

                  // NOTA: Hay varios lugares donde podriamos detectar para hacer la navegación a otra ruta, en este caso vamos a usar
                  //       la imágen para colocarle un detector y haga la navegación
                  return GestureDetector(
                    // NOTA: Recordemos que el push de go_router no destruye la anterior ruta por lo tanto podemos regresar a la pantalla anterior.
                    //       Si quisieramos destruir la ruta anterior usariamos el go
                    onTap: () => context.push('/home/0/movie/${movie.id}'),
                    child: FadeIn(child: child),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 5),

          //* Title
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textStyles.titleSmall,
            ),
          ),

          //* Rating - Calificación
          SizedBox(
            width: 150,
            child: Row(
              children: [
                // NOTA: El shade en el color son como alteraciones del color
                Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
                const SizedBox(width: 3),
                Text(
                  '${movie.voteAverage}',
                  style: textStyles.bodyMedium
                      ?.copyWith(color: Colors.yellow.shade800),
                ),
                const Spacer(),
                Text(HumanFormats.number(movie.popularity),
                    style: textStyles.bodySmall),
              ],
            ),
          )
        ],
      ),
    );
  }
}
