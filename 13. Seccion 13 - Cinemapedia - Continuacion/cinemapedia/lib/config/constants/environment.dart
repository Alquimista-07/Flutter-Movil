import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  // NOTA: Como nos dice que es un String opcional y que no puede venir entonces le decimos
  //       que si no viene agregue un mensaje indicando que no hay api key
  static String theMovieDbKey =
      dotenv.env['THE_MOVIEDB_KEY'] ?? 'No hay API Key';
}
