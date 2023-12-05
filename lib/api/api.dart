//import .env file
import 'package:minichallenge3/constants.dart';
import 'package:minichallenge3/models/movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  static const _trendingMoviesUrl =
      'https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.apiKey}';

  static const _trendingTvShowsUrl =
      'https://api.themoviedb.org/3/trending/tv/day?api_key=${Constants.apiKey}';

  static const _topRatedUrl =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.apiKey}';

  Future<List<Movie>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(_trendingMoviesUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      print(decodedData);
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load movies!');
    }
  }
}
