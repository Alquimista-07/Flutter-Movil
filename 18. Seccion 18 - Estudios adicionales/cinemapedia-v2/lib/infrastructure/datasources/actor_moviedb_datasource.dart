import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/infrastructure/mappers/mappers.dart';
import 'package:cinemapedia/infrastructure/models/models.dart';
import 'package:dio/dio.dart';

class ActorMovieDbDatasource extends ActorsDatasource {
  // NOTA: Instancia de dio
  final dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
    'api_key': Environment.theMovieDbKey,
    'language': 'es-MX',
  }));

  List<Actor> _jsonToCast(Map<String, dynamic> json) {
    final castResponse = CreditsResponse.fromJson(json);

    final List<Actor> actors = castResponse.cast
        .map((cast) => ActorMapper.castToEntity(cast))
        .toList();

    return actors;
  }

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');

    if (response.statusCode != 200) {
      throw Exception('Actor from movie id: $movieId not found');
    }

    return _jsonToCast(response.data);
  }
}
