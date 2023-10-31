class TvSeries {
  final String name;
  final String posterPath;
  final int id;
  final String overview;

  TvSeries(
      {required this.name,
      required this.posterPath,
      required this.id,
      required this.overview});

  factory TvSeries.fromJson(Map json) {
    if (json['poster_path'] == null) {
      json['poster_path'] =
          'https://cdn-icons-png.flaticon.com/512/31/31106.png';
    } else {
      json['poster_path'] =
          "https://image.tmdb.org/t/p/original${json['poster_path']}";
    }
    return TvSeries(
      name: json['name'],
      posterPath: json['poster_path'],
      id: json['id'],
      overview: json['overview'],
    );
  }
}
