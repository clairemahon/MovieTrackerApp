import 'package:minichallenge3/models/movie.dart';
import 'package:minichallenge3/models/tvshow.dart';

class SearchData {
  final List<Movie> todaysMovies;
  final List<TvShow> todaysTvShows;

  SearchData(
    this.todaysMovies,
    this.todaysTvShows,
  );
}
