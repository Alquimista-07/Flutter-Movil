// NOTA: Para crear este Slider lo podríamos hacer desde cero pero en este caso ya existe un paquete
//       llamado card_swiper que lo encontramos en https://pub.dev/packages/card_swiper y que nos sirve
//       bastante para lo que queremos hacer.
import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:go_router/go_router.dart';

class MoviesSlideshow extends StatelessWidget {
  // NOTA: Vamos a necesitar un listado de películas
  final List<Movie> movies;

  const MoviesSlideshow({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 210,
      width: double.infinity,
      child: Swiper(
        // NOTA: El viewportFraction hace que el slide muestre un pedazo del anterior y del siguiente slide
        viewportFraction: 0.8,
        // NOTA: El scale hace que los slide sean un poquito más pequeños
        scale: 0.9,
        // NOTA: El autoplay hace que los slides vayan cambiando automáticamente
        autoplay: true,
        // NOTA: Acá usasmos el paginador, en la documentación podemos encontrar más información y otros tipos
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(
              activeColor: colors.primary, // Color primario
              color: colors.secondary // Color secundario
              ),
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) => _Slide(movie: movies[index]),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    // NOTA: La propiedad decoration se definió para separar un poco el código y que sea fácil de leer, pero básicamente
    //       esta propiedad la tomamos para personalizar como queremos que se vena las cajas de los slides en el carrusel.
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
            color: Colors.black45,
            // El blurRadius es el difuninado en los bordes
            blurRadius: 10,
            // EL offset son las coordenadas en X y Y que queremos mover esas sombra o difuminado
            offset: Offset(0, 10))
      ],
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        // NOTA: El widget ClipRRect me permite colocar bordes redondeados
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: GestureDetector(
            onTap: () => context.push('/home/0/movie/${movie.id}'),
            child: FadeInImage(
              // NOTA: Con la propiedad fit ajustamos el tamaño de la imágen para que se adapte al padre.
              fit: BoxFit.cover,
              placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
              image: NetworkImage(movie.backdropPath),
            ),
          ),
        ),
      ),
    );
  }
}
