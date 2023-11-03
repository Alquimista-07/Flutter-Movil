import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

// NOTA: Voy a definirme un tipo de función específica que me va a ayudar a definir el tipo del método
//       searchMovies que voy a crear para que sea llamado por el build buildSuggestions y va a hacer
//       el trabajo de buscar las películas que coincidan con el query.
//       Y por lo tanto ya la función que ese este typedef tiene que cumplir con esta firma
typedef SearcMoviesCallback = Future<List<Movie>> Function(String query);

// NOTA: OJO hay que tener en cuenta que al extender del SearchDelegate nos va a pedir que implementemos cuatro métodos
//       (buildActions, buildLeading, buildResults y buildSuggestions) los cuales al implementarlos nos va a indicar que
//       algunos métodos son opcionales (2 métodos), y otros obligatorios (2 métodos), adicionalmente hay que mirar el tipo
//       de dato que regresan.
// NOTA: Otra cosa que vamos a hacer es que como queremos retornar el objeto movie completo y no solo el id entonces en el
//       extend del SearchDelegate colocamos el objeto y lo dejamos opcional pero como se mencionó podría ser solo el id
//       (String?).
class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearcMoviesCallback searchMovies;

  SearchMovieDelegate({required this.searchMovies});

  // NOTA: Otra cosa es que nosotros podemos implementar otro override que no es obligatorio al estender del SearchDelegate
  //       pero que nos va a servir para cambiar el texto de la caja de texto para que no diga Search sino lo que nosotros
  //       indiquemos
  @override
  String get searchFieldLabel => 'Buscar Película';

  // NOTA: Este es como para contruir las acciones
  @override
  List<Widget>? buildActions(BuildContext context) {
    //return [const Text('BuildActions')];
    return [
      // NOTA: Colocamos un botón para limpiar lo que se escribió pero de forma condicional para que no se muestre si no hay nada
      //       escrito
      //       Entonces en este caso vamos a usar una propiedad que nos ofrece el SearchDelegate que es el query la cual contiene
      //       la información de esa caja de texto, por lo tanto podemos setearle un nuevo valor por ejemplo un valor vacío y de
      //       esta forma ya lo limpiamos

      //if (query.isNotEmpty)
      FadeIn(
        // NOTA: Una propiedad adicional del fadeIn del animate_do es el animate, que es un valor booleano el cual trabaja en vase a una condición
        //       y fácilmente esta reemplazaría al if que teniamos anteriormente
        animate: query.isNotEmpty,
        //duration: const Duration(milliseconds: 200), // Velociadad de la animación
        child: IconButton(
            icon: const Icon(Icons.clear), onPressed: () => query = ''),
      )
    ];
  }

  // NOTA: Este sería como para construir un icono o la parte que esta al inicio del AppBar donde tenemos el título de la aplicación (Cinemapedi)
  @override
  Widget? buildLeading(BuildContext context) {
    //return const Text('BuildLeading');
    // NOTA: En este caso vamos a poner un botón para regresar a la ventana principal
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
      // NOTA: Entonces en este caso ya tenemos a la mano un método que nos ofrece el SearchDelegate que es el close
      //       el cual recibe el context y un result, el result es lo que yo quiero regresar cuando cierre el showsearch.
      //       En este caso como estoy en el buildLeading suponemos que la persona no hizo nada ya que estamos dando atrás
      //       entonces mandamos un null
      onPressed: () => close(context, null),
    );
  }

  // NOTA: Este serían los resultados que van a aparecer cuando el usuario persione Enter
  @override
  Widget buildResults(BuildContext context) {
    return const Text('BuildResults');
  }

  // NOTA: Este sería para cuando la persona este escribiendo y es el que en este caso vamos a usar ya que la idea es que el usuario
  //       vaya escribiendo y cuando se detenga y pase un tiempo determinado ahí se dispare la petición y se realice la búsqueda.
  @override
  Widget buildSuggestions(BuildContext context) {
    //return const Text('BuildSuggestions');
    // NOTA: Acá vamos a disparar la petición y contruir el widget donde se van a mostrar los resultados.
    //       Ahora el widget que ocupariamos para trabajar y que sirva con un Future. Entonces usaríamos
    //       un FutureBuilder
    return FutureBuilder(
      future: searchMovies(query),
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return ListTile(title: Text(movie.title));
          },
        );
      },
    );
  }
}
