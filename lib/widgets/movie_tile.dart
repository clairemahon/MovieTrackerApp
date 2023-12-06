import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minichallenge3/constants.dart';
import 'package:minichallenge3/models/movie.dart';
import 'package:minichallenge3/screens/details_screen.dart';

// MovieTile is a StatelessWidget that displays a movie poster
class MovieTile extends StatelessWidget {
  final Movie item;
  final Function(bool?)? onComplete;
  final TextDecoration textDecoration;

  MovieTile({
    super.key,
    required this.item,
    required this.snapshot,
    this.onComplete,
  }) : textDecoration =
            item.isComplete ? TextDecoration.lineThrough : TextDecoration.none;

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  buildCheckbox(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            movie: snapshot.data[index],
                          ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: 200,
                        height: 150,
                        child: Image.network(
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                          '${Constants.imagePath}${snapshot.data![index].posterPath}',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }

  Widget buildCheckbox() {
    return Checkbox(
      value: item.isComplete,
      onChanged: onComplete,
    );
  }
}
