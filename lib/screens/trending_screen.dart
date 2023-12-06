import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minichallenge3/api/api.dart';
import 'package:minichallenge3/models/movie.dart';
import 'package:minichallenge3/widgets/movies_slider.dart';
import 'package:minichallenge3/widgets/trending_slider.dart';

// TrendingScreen is the screen that displays the trending movies,
// top rated movies, and upcoming movies
// It serves as the main page a user sees when they open the app

class TrendingScreen extends StatelessWidget {
  final apiService = Api();

  TrendingScreen({super.key});

  late Future<List<Movie>> trendingMovies;
  late Future<List<Movie>> topRatedMovies;
  late Future<List<Movie>> upcomingMovies;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Trending Movies', style: GoogleFonts.aBeeZee(fontSize: 25)),
              const SizedBox(height: 20),
              SizedBox(
                  child: FutureBuilder(
                future: trendingMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    return TrendingSlider(
                      snapshot: snapshot,
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              )),
              const SizedBox(height: 20),
              Text('Top Rated Movies',
                  style: GoogleFonts.aBeeZee(fontSize: 25)),
              const SizedBox(height: 20),
              SizedBox(
                  child: FutureBuilder(
                future: topRatedMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    return MoviesSlider(
                      snapshot: snapshot,
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              )),
              const SizedBox(height: 20),
              Text('Upcoming Movies', style: GoogleFonts.aBeeZee(fontSize: 25)),
              const SizedBox(height: 20),
              SizedBox(
                  child: FutureBuilder(
                future: upcomingMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    return MoviesSlider(
                      snapshot: snapshot,
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
