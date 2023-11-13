// Entity para los videos de YouTube
class Video {
  final String id;
  final String name;
  final String youtubeKey;
  final DateTime publisedAt;

  Video({
    required this.id,
    required this.name,
    required this.youtubeKey,
    required this.publisedAt,
  });
}
