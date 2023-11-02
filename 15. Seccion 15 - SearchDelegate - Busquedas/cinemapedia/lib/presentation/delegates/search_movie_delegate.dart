import 'package:flutter/material.dart';

// NOTA: OJO hay que tener en cuenta que al extender del SearchDelegate nos va a pedir que implementemos cuatro métodos
//       (buildActions, buildLeading, buildResults y buildSuggestions) los cuales al implementarlos nos va a indicar que
//       algunos métodos son opcionales (2 métodos), y otros obligatorios (2 métodos), adicionalmente hay que mirar el tipo
//       de dato que regresan.

class SearchMovieDelegate extends SearchDelegate {
  // NOTA: Otra cosa es que nosotros podemos implementar otro override que no es obligatorio al estender del SearchDelegate
  //       pero que nos va a servir para cambiar el texto de la caja de texto para que no diga Search sino lo que nosotros
  //       indiquemos
  @override
  String get searchFieldLabel => 'Buscar Película';

  // NOTA: Este es como para contruir las acciones
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [const Text('BuildActions')];
  }

  // NOTA: Este sería como para construir un icono o la parte que esta al inicio del AppBar donde tenemos el título de la aplicación (Cinemapedi)
  @override
  Widget? buildLeading(BuildContext context) {
    return const Text('BuildLeading');
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
    return const Text('BuildSuggestions');
  }
}
