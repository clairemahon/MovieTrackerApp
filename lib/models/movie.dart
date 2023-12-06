// The Movie class represents a movie object, pulling the data from
// TMBD about the movie and relevant information for the app.

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
  final bool isComplete;

  Movie(
      {required this.title,
      required this.backDropPath,
      required this.originalTitle,
      required this.overview,
      required this.posterPath,
      required this.genreIds,
      required this.releaseDate,
      required this.voteAverage,
      required this.releaseDateFormatted,
      required this.adult,
      this.isComplete = false});

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
        adult: json['adult']);
  }

  Movie copyWith(
      {String? title,
      String? backDropPath,
      String? originalTitle,
      String? overview,
      String? posterPath,
      List<dynamic>? genreIds,
      String? releaseDate,
      double? voteAverage,
      DateTime? releaseDateFormatted,
      bool? adult, // PEGI rating (adult film or not)
      bool? isComplete}) {
    return Movie(
        title: title ?? this.title,
        backDropPath: backDropPath ?? this.backDropPath,
        originalTitle: originalTitle ?? this.originalTitle,
        overview: overview ?? this.overview,
        posterPath: posterPath ?? this.posterPath,
        genreIds: genreIds ?? this.genreIds,
        releaseDate: releaseDate ?? this.releaseDate,
        releaseDateFormatted: releaseDateFormatted ?? this.releaseDateFormatted,
        voteAverage: voteAverage ?? this.voteAverage,
        adult: adult ?? this.adult,
        isComplete: isComplete ?? this.isComplete);
  }
}
