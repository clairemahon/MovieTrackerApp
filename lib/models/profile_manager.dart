import 'package:flutter/material.dart';
import 'movie.dart';

// ProfileManager is a ChangeNotifier that holds the state of
// the user's preferences and saved movies
class ProfileManager extends ChangeNotifier {
  final _savedMovies = <Movie>[];
  List<Movie> get savedMovies => List.unmodifiable(_savedMovies);

  void deleteItem(int index) {
    _savedMovies.removeAt(index);
    notifyListeners();
  }

  String getItemId(int index) {
    final savedMovie = _savedMovies[index];
    return savedMovie.title;
  }

  Movie? getSavedMovie(String id) {
    final index = _savedMovies.indexWhere((element) => element.title == id);
    if (index == -1) return null;
    return savedMovies[index];
  }

  void addItem(Movie item) {
    _savedMovies.add(item);
    notifyListeners();
  }

  void updateItem(Movie item) {
    final index =
        _savedMovies.indexWhere((element) => element.title == item.title);
    _savedMovies[index] = item;
    notifyListeners();
  }

  void completeItem(int index, bool change) {
    final item = _savedMovies[index];
    _savedMovies[index] = item.copyWith(isComplete: change);
    notifyListeners();
  }
}
