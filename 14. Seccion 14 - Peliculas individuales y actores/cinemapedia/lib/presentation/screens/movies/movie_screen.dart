import 'package:flutter/material.dart';

class MovieScreen extends StatefulWidget {
  static const name = 'movie-screen';

  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  // NOTA: Vamos a usar el initstate para saber cuando estoy cargando, cuando termino de cargar, entre otras
  //       cosas. Adicionalmente vamos a manejar un cache local para también mostrar un loading y para hacer
  //       más eficiente la aplicación y no hacer una petición nuevamente si ya anteriormente habíamos ingresado
  //       a ver la información de esa película
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MovieID: ${widget.movieId}'),
      ),
    );
  }
}
