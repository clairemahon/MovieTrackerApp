//import .env file
import 'package:minichallenge3/constants.dart';
import 'package:minichallenge3/models/movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:minichallenge3/models/actor.dart';
import 'package:minichallenge3/models/genre.dart';
import 'package:minichallenge3/models/search_data.dart';
import 'package:minichallenge3/models/tvshow.dart';

class Api {
  static const _trendingMoviesUrl =
      'https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.apiKey}';

  static const _trendingTvShowsUrl =
      'https://api.themoviedb.org/3/trending/tv/day?api_key=${Constants.apiKey}';

  static const _topRatedUrl =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.apiKey}';

  static const _upcomingMoviesUrl =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=${Constants.apiKey}';

  static const _castListUrl =
      'https://api.themoviedb.org/3/movie/550/credits?api_key=${Constants.apiKey}';

  Future<SearchData> getExploreData() async {
    final todayMovies = await getTrendingMovies();
    final todayTvShows = await getTrendingTVShows();

    return SearchData(todayMovies, todayTvShows);
  }

  Future<List<Movie>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(_trendingMoviesUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      print(decodedData);
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load Trending movies!');
    }
  }

  Future<List<Movie>> getFavoriteMovies() async {
    final response = await http.get(Uri.parse(_trendingMoviesUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load Favorite movies!');
    }
  }

  Future<List<TvShow>> getTrendingTVShows() async {
    final response = await http.get(Uri.parse(_trendingTvShowsUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      print(decodedData);
      return decodedData.map((tvshow) => TvShow.fromJson(tvshow)).toList();
    } else {
      throw Exception('Failed to load Trending TV!');
    }
  }

  Future<List<Movie>> getTopRatedMovies() async {
    final response = await http.get(Uri.parse(_topRatedUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load Top Rated movies!');
    }
  }

  Future<List<Movie>> getUpcomingMovies() async {
    final response = await http.get(Uri.parse(_upcomingMoviesUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load Top Rated movies!');
    }
  }

  Future<List<Genre>> getGenreList() async {
    final response = await http.get(Uri.parse(_castListUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((genre) => Genre.fromJson(genre)).toList();
    } else {
      throw Exception('Failed to load Genres!');
    }
  }

  Future<List<Actor>> getCastList(int movieId) async {
    final response = await http.get(Uri.parse(_castListUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((actor) => Actor.fromJson(actor)).toList();
    } else {
      throw Exception('Failed to load Cast List!');
    }
  }
}
