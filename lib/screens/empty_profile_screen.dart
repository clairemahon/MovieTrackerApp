import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minichallenge3/models/app_state_manager.dart';

class EmptyProfileScreen extends StatelessWidget {
  const EmptyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Image.asset('assets/CineScreen.png'),
              ),
            ),
            Text(
              'No Saved Favorites Yet',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Looking for New Movies?\n'
              'Tap the + button to write them down!',
              textAlign: TextAlign.center,
            ),
            MaterialButton(
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              color: Colors.green,
              onPressed: () {
                context.goNamed(
                  '/trending',
                  pathParameters: {'tab': '${CineScreenTab.trending}'},
                );
              },
              child: const Text('Browse Movies'),
            ),
          ],
        ),
      ),
    );
  }
}
