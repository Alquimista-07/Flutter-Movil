// NOTA: Acá usamos Quicktype.io para generar este código en Dart con Null Safety y Make all properties final
//       Esto lo hacemos tomando la respuesta que nos da la API en formato JSON para autogenerar el código y
//       adicionalmente procedemos a borrar algunas cosas y hacer unos ajustes necesarios para que se ajuste
//       la necesidad que nosotros tenemos.

import 'movie_moviedb.dart';

class MovieDbResponse {
  final Dates? dates;
  final int page;
  final List<MovieMovieDB> results;
  final int totalPages;
  final int totalResults;

  MovieDbResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieDbResponse.fromJson(Map<String, dynamic> json) =>
      MovieDbResponse(
        // NOTA: Acá validamos en caso de que no venga la data
        dates: json["dates"] ? Dates.fromJson(json["dates"]) : null,
        page: json["page"],
        results: List<MovieMovieDB>.from(
            json["results"].map((x) => MovieMovieDB.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        // NOTA: Nuevamente validamos en caso de que sea nulo y adicionalmente agregamos el simbolo ! ya que nosotros sabemos que
        //       anteriormente lo validamos entonces con ese simbolo indicamos que lo deje pasar y no marque error.
        "dates": dates == null ? null : dates!.toJson(),
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Dates {
  final DateTime maximum;
  final DateTime minimum;

  Dates({
    required this.maximum,
    required this.minimum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
      );

  Map<String, dynamic> toJson() => {
        "maximum":
            "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
        "minimum":
            "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
      };
}
