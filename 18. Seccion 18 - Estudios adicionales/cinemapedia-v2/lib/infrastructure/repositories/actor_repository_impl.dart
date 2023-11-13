import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/domain/repositories/actors_repository.dart';

class ActorrepositoryImpl extends ActorsRepository {
  // NOTA: OJO no queremos amarrar a actors de the moviedb (ActorMovieDbDatasource) sino que queremos hacerlo de forma general ()
  final ActorsDatasource datasource;

  ActorrepositoryImpl(this.datasource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return datasource.getActorsByMovie(movieId);
  }
}
