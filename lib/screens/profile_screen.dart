import 'package:flutter/material.dart';
import 'package:minichallenge3/models/profile_manager.dart';
import 'package:minichallenge3/screens/empty_profile_screen.dart';
import 'package:minichallenge3/screens/favorites_list_screen.dart';
import 'package:provider/provider.dart';

// ProfileScreen is the screen that displays the user's profile preferences,
// showing them either the option to add new favorites or showing ones they've already added
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // TODO: Add a movie to your favorites list
        },
      ),
      body: buildProfileScreen(),
    );
  }

  Widget buildProfileScreen() {
    return Consumer<ProfileManager>(
      builder: (context, manager, child) {
        if (manager.savedMovies.isNotEmpty) {
          return FavoritesListScreen(manager: manager);
        } else {
          return const EmptyProfileScreen();
        }
      },
    );
  }
}
