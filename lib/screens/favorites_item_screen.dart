import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minichallenge3/api/api.dart';
import 'package:minichallenge3/models/movie.dart';
import 'package:minichallenge3/widgets/movie_tile.dart';
import 'package:uuid/uuid.dart';

// FavoritesItemScreen is the screen that allows the user to create or update a movie item
// adding it to their own personal favorites list on their profile page

class FavoritesItemScreen extends StatefulWidget {
  final Function(Movie) onCreate;
  final Function(Movie) onUpdate;
  final Movie? originalItem;
  final int index;
  final bool isUpdating;

  const FavoritesItemScreen({
    super.key,
    required this.onCreate,
    required this.onUpdate,
    this.originalItem,
    this.index = -1,
  }) : isUpdating = (originalItem != null);

  @override
  FavoritesItemScreenState createState() => FavoritesItemScreenState();
}

class FavoritesItemScreenState extends State<FavoritesItemScreen> {
  final _nameController = TextEditingController();
  String _name = '';
  int _currentSliderValue = 0;

  late Future<List<Movie>> favoriteMovies;

  @override
  void initState() {
    super.initState();
    favoriteMovies = Api().getFavoriteMovies();

    final originalMovie = widget.originalItem;
    if (originalMovie != null) {
      _name = originalMovie.title;
      _nameController.text = originalMovie.title;
    }

    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              final movie = Movie(
                title: widget.originalItem?.title ?? const Uuid().v1(),
                backDropPath: widget.originalItem?.backDropPath ?? '',
                originalTitle: widget.originalItem?.originalTitle ?? '',
                overview: widget.originalItem?.overview ?? '',
                posterPath: widget.originalItem?.posterPath ?? '',
                genreIds: widget.originalItem?.genreIds ?? [],
                releaseDate: widget.originalItem?.releaseDate ?? '',
                voteAverage: widget.originalItem?.voteAverage ?? 0.0,
                releaseDateFormatted:
                    widget.originalItem?.releaseDateFormatted ?? DateTime.now(),
                adult: widget.originalItem?.adult ?? false,
                isComplete: widget.originalItem?.isComplete ?? false,
              );

              if (widget.isUpdating) {
                widget.onUpdate(movie);
              } else {
                widget.onCreate(movie);
              }
            },
          )
        ],
        elevation: 0.0,
        title: Text(
          'Movie Item',
          style: GoogleFonts.lato(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder(
          future: favoriteMovies,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              return MovieTile(
                item: Movie(
                  title: _name,
                  backDropPath: '',
                  originalTitle: '',
                  overview: '',
                  posterPath: '',
                  genreIds: [],
                  releaseDate: '',
                  voteAverage: 0.0,
                  releaseDateFormatted: DateTime.now(),
                  adult: false,
                  isComplete: false,
                ),
                onComplete: (change) {},
                snapshot: snapshot,
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
