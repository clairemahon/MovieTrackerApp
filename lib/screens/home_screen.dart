import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../main.dart';
import '../media/media_list.dart';
import '../mymedia/my_media_list.dart';
import '../watchlist/watch_list.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List<Widget> pageList = <Widget>[];
  // TODO: Add index key

  @override
  void initState() {
    super.initState();
    pageList.add(const MediaList());
    pageList.add(const MyMediaList());
    pageList.add(const WatchList());
    // TODO: Call getCurrentIndex
  }

  // TODO: Add saveCurrentIndex

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
        title = 'My Movies & TV Shows';
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
              icon: SvgPicture.asset('assets/images/icon_bookmarks.svg',
                  color: _selectedIndex == 0 ? green : Colors.grey,
                  semanticsLabel: 'My Movies'),
              label: 'My Movies & TV Shows'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/icon_shopping_list.svg',
                  color: _selectedIndex == 1 ? green : Colors.grey,
                  semanticsLabel: 'My Profile'),
              label: 'My Profile'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/icon_recipe.svg',
                  color: _selectedIndex == 2 ? green : Colors.grey,
                  semanticsLabel: 'Search'),
              label: 'Search'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: green,
        onTap: _onItemTapped,
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          statusBarColor: Colors.white,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarDividerColor: Colors.white,
          //Navigation bar divider color
          systemNavigationBarIconBrightness:
              Brightness.light, //navigation bar icon
        ),
        title: Text(
          title,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: pageList,
      ),
    );
  }
}
