import 'package:flutter/material.dart';
import 'package:minichallenge3/models/movie.dart';
import 'package:minichallenge3/models/profile_manager.dart';
import 'package:minichallenge3/screens/details_screen.dart';
import 'package:minichallenge3/widgets/favorites_slider.dart';
import 'package:minichallenge3/widgets/movie_tile.dart';

// FavoritesListScreen is the screen that displays the user's
// favorites list from their profile preferences
class FavoritesListScreen extends StatelessWidget {
  final ProfileManager manager;

  const FavoritesListScreen({
    super.key,
    required this.manager,
  });

  get snapshot => snapshot;

  @override
  Widget build(BuildContext context) {
    final savedMovies = manager.savedMovies;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemCount: savedMovies.length,
        itemBuilder: (context, index) {
          final item = savedMovies[index];
          return Dismissible(
            key: Key(item.title),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.delete_forever,
                color: Colors.white,
                size: 50.0,
              ),
            ),
            onDismissed: (direction) {
              manager.deleteItem(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${item.title} unfavorited'),
                ),
              );
            },
            child: InkWell(
              child: MovieTile(
                key: Key(item.title),
                item: item,
                onComplete: (change) {
                  if (change != null) {
                    manager.completeItem(index, change);
                  }
                },
                snapshot: snapshot,
              ),
              onTap: () {
                DetailsScreen(movie: item);
              },
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16.0);
        },
      ),
    );
  }
}
