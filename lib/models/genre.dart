// Genre represents the movie/tv show genre being called from the API

class Genre {
  int id;
  String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(dynamic json) {
    return Genre(id: json['id'], name: json['name']);
  }
}
