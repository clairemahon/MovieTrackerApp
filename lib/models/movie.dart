class Movie {
  String title;
  String backDropPath;
  String originalTitle;
  String overview;
  String posterPath;
  List<dynamic> genreIds;
  String releaseDate;
  double voteAverage;
  DateTime releaseDateFormatted;
  bool adult; // PEGI rating (adult film or not)

  Movie({
    required this.title,
    required this.backDropPath,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.genreIds,
    required this.releaseDate,
    required this.voteAverage,
    required this.releaseDateFormatted,
    required this.adult,
  });

// factory constructor converts a map (JSON) to a Movie object
// takes string and dynamic as arguments from json

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      backDropPath: json['backdrop_path'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      posterPath: json['poster_path'].toString(),
      genreIds: json['genre_ids'],
      releaseDate: json['release_date'].toString(),
      voteAverage: json['vote_average'].toDouble(),
      releaseDateFormatted: DateTime.parse(json['release_date']),
      adult: json['adult'],
    );
  }
}

// If we were to post to the API
// Map<String, dynamic> toJson() -> {
//       return {
//         'title': title,
//         'backdrop_path': backDropPath,
//         'original_title': originalTitle,
//         'overview': overview,
//         'poster_path': posterPath,
//         'genre_ids': genreIds,
//         'release_date': releaseDate,
//         'vote_average': voteAverage,
//         'release_date_formatted': releaseDateFormatted,
//         'adult': adult,
//       };
//     }



// "page": 1,
//   "results": [
//     {
//       "adult": false,
//       "backdrop_path": "/fc2pEZgr0ltmyzLl4cO9JInOg6l.jpg",
//       "id": 798021,
//       "title": "Family Switch",
//       "original_language": "en",
//       "original_title": "Family Switch",
//       "overview": "When the walker  family members switch bodies with each other during a rare planetary alignment, their hilarious journey to find their way back to normal will bring them closer together than they ever thought possible.",
//       "poster_path": "/fnRUCA0fjEb3kuIaTGogL7425IC.jpg",
//       "media_type": "movie",
//       "genre_ids": [
//         35,
//         14,
//         10751
//       ],
//       "popularity": 113.014,
//       "release_date": "2023-11-30",
//       "video": false,
//       "vote_average": 6.042,
//       "vote_count": 24
//     },