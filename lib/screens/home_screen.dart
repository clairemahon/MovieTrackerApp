import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minichallenge3/api/api.dart';
import 'package:minichallenge3/models/movie.dart';
import 'package:minichallenge3/screens/search_screen.dart';
import 'package:minichallenge3/screens/user_screen.dart';
import 'package:minichallenge3/screens/trending_screen.dart';
import 'package:minichallenge3/widgets/movies_slider.dart';
import 'package:minichallenge3/widgets/trending_slider.dart';
import '../media/media_list.dart';
import '../mymedia/my_media_list.dart';
// import '../watchlist/watch_list.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minichallenge3/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

// MainScreen is the home page of the app - trending is the automatic display,
// it also includes navigation to the search screen and the profile screen

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
    required this.currentTab,
  });

  final int currentTab;

  @override
  State createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List<Widget> pageList = <Widget>[
    TrendingScreen(),
    SearchScreen(),
  ];
  static const String prefSelectedIndexKey = 'selectedIndex';

  late Future<List<Movie>> trendingMovies;
  late Future<List<Movie>> topRatedMovies;
  late Future<List<Movie>> upcomingMovies;

  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovies();
    topRatedMovies = Api().getTopRatedMovies();
    upcomingMovies = Api().getUpcomingMovies();
    pageList.add(const MediaList());
    pageList.add(const MyMediaList());
    // pageList.add(const WatchList());
  }

  void saveCurrentIndex() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(prefSelectedIndexKey, _selectedIndex);
  }

  void getCurrentIndex() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(prefSelectedIndexKey)) {
      setState(() {
        final index = prefs.getInt(prefSelectedIndexKey);
        if (index != null) {
          _selectedIndex = index;
        }
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    saveCurrentIndex();
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.trending_up_outlined,
                  color: _selectedIndex == 0 ? Colors.green : Colors.grey),
              label: 'Trending'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline,
                  color: _selectedIndex == 1 ? Colors.green : Colors.grey),
              label: 'My Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined,
                  color: _selectedIndex == 2 ? Colors.green : Colors.grey),
              label: 'Search'),
        ],
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
      body: SizedBox(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Trending Movies',
                    style: GoogleFonts.aBeeZee(fontSize: 25)),
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
                Text('Upcoming Movies',
                    style: GoogleFonts.aBeeZee(fontSize: 25)),
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
      ),
    );
  }
}
