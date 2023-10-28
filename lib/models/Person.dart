class Person {
  final String name;
  final String posterPath;
  final int id;
  final List<dynamic> knownFor;

  Person(
      {required this.name,
      required this.posterPath,
      required this.id,
      required this.knownFor});

  factory Person.fromJson(Map json) {
    var listMovies = [];
    if (json['profile_path'] == null) {
      json['profile_path'] =
          'https://www.iconpacks.net/icons/2/free-user-icon-3296-thumb.png';
    } else {
      json['profile_path'] =
          "https://image.tmdb.org/t/p/original${json['profile_path']}";
    }
    if (json['known_for'].isNotEmpty) {
      for (var i = 0; i < json['known_for'].length; i++) {
        listMovies.add(json['known_for'][i]['title']);
      }
    }
    return Person(
      name: json['name'],
      posterPath: json['profile_path'],
      id: json['id'],
      knownFor: listMovies,
    );
  }
}
