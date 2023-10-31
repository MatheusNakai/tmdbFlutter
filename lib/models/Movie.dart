class Movie {
  final String name;
  final String posterPath;
  final int id;
  final String overview;

  Movie(
      {required this.name,
      required this.posterPath,
      required this.id,
      required this.overview});

  factory Movie.fromJson(Map json) {
    if (json['poster_path'] == null) {
      json['poster_path'] =
          'https://static.vecteezy.com/system/resources/previews/016/017/438/original/movie-camera-icon-free-png.png';
    } else {
      json['poster_path'] =
          "https://image.tmdb.org/t/p/original${json['poster_path']}";
    }
    return Movie(
      name: json['title'],
      posterPath: json['poster_path'],
      id: json['id'],
      overview: json['overview'],
    );
  }
}
