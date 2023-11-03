// NOTA: Acá usamos Quicktype.io para generar este código en Dart con Null Safety y Make all properties final
//       Esto lo hacemos tomando la respuesta que nos da la API en formato JSON para autogenerar el código y
//       adicionalmente procedemos a borrar algunas cosas y hacer unos ajustes necesarios para que se ajuste
//       la necesidad que nosotros tenemos.
class MovieMovieDB {
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime? releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieMovieDB({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieMovieDB.fromJson(Map<String, dynamic> json) => MovieMovieDB(
        // NOTA: Si no viene el valor que es una película para adultos establecemos el valor por defecto en false
        adult: json["adult"] ?? false,
        // NOTA: Ajustamos para que si el backdropPath no viene lo coloque como un string vacío ya que todas las películas no lo tienen
        backdropPath: json["backdrop_path"] ?? '',
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"] ?? '',
        originalTitle: json["original_title"] ?? '',
        // NOTA: Ajustamos para que si el overview regrese un valor por defecto ya que todas las películas no lo tienen
        overview: json["overview"] ?? '',
        popularity: json["popularity"]?.toDouble() ?? 0,
        // NOTA: Ajustamos para que si el posterPath regrese un valor por defecto ya que todas las películas no lo tienen
        posterPath: json["poster_path"] ?? '',
        releaseDate: json["release_date"] != null &&
                json["release_date"].toString().isNotEmpty
            ? DateTime.parse(json["release_date"])
            : null,
        title: json["title"] ?? 'No Title',
        video: json["video"] ?? false,
        voteAverage: json["vote_average"]?.toDouble() ?? 0,
        voteCount: json["vote_count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date": releaseDate != null
            ? "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}"
            : null,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}
