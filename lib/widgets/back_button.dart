import 'package:flutter/material.dart';

// ReturnButton is a StatelessWidget that returns the user to the previous screen
// It is most notably implemented when a user clicks on a movie to show the details page
// and then clicks out of it to return to the TrendingScreen

class ReturnButton extends StatelessWidget {
  const ReturnButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        width: 70,
        margin: const EdgeInsets.only(top: 16, left: 16),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ));
  }
}
