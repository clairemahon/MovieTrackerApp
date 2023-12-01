import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minichallenge3/api/api.dart';
import 'package:minichallenge3/models/movie.dart';
import 'package:minichallenge3/widgets/movies_slider.dart';
import 'package:minichallenge3/widgets/trending_slider.dart';
import '../media/media_list.dart';
import '../mymedia/my_media_list.dart';
import '../watchlist/watch_list.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minichallenge3/colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List<Widget> pageList = <Widget>[];
  // TODO: Add index key

  late Future<List<Movie>> trendingMovies;

  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovies();
    pageList.add(const MediaList());
    pageList.add(const MyMediaList());
    pageList.add(const WatchList());

    // TODO: Call getCurrentIndex
    // TODO: Add saveCurrentIndex
  }

  // TODO: Add getCurrentIndex

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // TODO: Call saveCurrentIndex
  }

  @override
  Widget build(BuildContext context) {
    String title;
    switch (_selectedIndex) {
      case 0:
        title = 'Trending';
        break;
      case 1:
        title = 'My Profile';
        break;
      case 2:
        title = 'Search';
        break;
      default:
        title = 'My Movies & TV Shows';
        break;
    }
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/favorite.svg',
                  color: _selectedIndex == 0 ? Colors.green : Colors.grey,
                  semanticsLabel: 'My Movies'),
              label: 'Trending'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/favorite.svg',
                  color: _selectedIndex == 1 ? Colors.green : Colors.grey,
                  semanticsLabel: 'My Profile'),
              label: 'My Profile'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/favorite.svg',
                  color: _selectedIndex == 2 ? Colors.green : Colors.grey,
                  semanticsLabel: 'Search'),
              label: 'Search'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Trending Movies', style: GoogleFonts.aBeeZee(fontSize: 25)),
              const SizedBox(height: 20),
              const TrendingSlider(),
              const SizedBox(height: 20),
              Text('Top Rated Movies',
                  style: GoogleFonts.aBeeZee(fontSize: 25)),
              const SizedBox(height: 20),
              const MoviesSlider(),
              const SizedBox(height: 20),
              Text('Upcoming Movies', style: GoogleFonts.aBeeZee(fontSize: 25)),
              const SizedBox(height: 20),
              const MoviesSlider(),
            ],
          ),
        ),
      ),
    );
  }
}
