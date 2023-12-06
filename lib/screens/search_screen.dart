import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../api/api.dart';

// SearchScreen is the screen that displays the search bar and the results
// it allows users to search for Movies and TV shows
class SearchScreen extends StatelessWidget {
  final apiService = Api();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Image.asset(
          'assets/CineScreen.png',
          fit: BoxFit.cover,
          height: 40,
          filterQuality: FilterQuality.high,
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white,
            statusBarColor: Colors.white,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarDividerColor: Colors.white,
            //Navigation bar divider color
            systemNavigationBarIconBrightness:
                Brightness.light //navigation bar icon
            ),
      ),
    );
  }
}
