import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../widgets/custom_dropdown.dart';
import 'package:minichallenge3/colors.dart';

// TODO: Add imports

class MediaList extends StatefulWidget {
  const MediaList({Key? key}) : super(key: key);

  @override
  State createState() => _MediaListState();
}

class _MediaListState extends State<MediaList> {
  static const String prefSearchKey = 'previousSearches';
  late TextEditingController searchTextController;
  final ScrollController _scrollController = ScrollController();
  List currentSearchList = [];
  int currentCount = 0;
  int currentStartPosition = 0;
  int currentEndPosition = 20;
  int pageCount = 20;
  bool hasMore = false;
  bool loading = false;
  bool inErrorState = false;
  List<String> previousSearches = <String>[];
  // TODO: Add _currentRecipes1

  @override
  void initState() {
    super.initState();
    // TODO: Call loadMedia()

    getPreviousSearches();
    searchTextController = TextEditingController(text: '');
    _scrollController.addListener(() {
      final triggerFetchMoreSize =
          0.7 * _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels > triggerFetchMoreSize) {
        if (hasMore &&
            currentEndPosition < currentCount &&
            !loading &&
            !inErrorState) {
          setState(() {
            loading = true;
            currentStartPosition = currentEndPosition;
            currentEndPosition =
                min(currentStartPosition + pageCount, currentCount);
          });
        }
      }
    });
  }

  // TODO: Add loadRecipes

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  void savePreviousSearches() async {
    await _secureStorage.write(
      key: prefSearchKey,
      value:
          previousSearches.join(','), // Convert List to a string for simplicity
    );
  }

  void getPreviousSearches() async {
    final value = await _secureStorage.read(key: prefSearchKey);
    if (value != null) {
      previousSearches =
          value.split(','); // Convert the stored string back to a List
    } else {
      previousSearches = <String>[];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildSearchCard(),
            _buildMediaLoader(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchCard() {
    return Card(
      elevation: 4,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                startSearch(searchTextController.text);
                final currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
            ),
            const SizedBox(
              width: 6.0,
            ),
            Expanded(
                child: TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
              ),
              autofocus: false,
              textInputAction: TextInputAction.done,
              onSubmitted: (value) {
                startSearch(searchTextController.text);
              },
              controller: searchTextController,
            )),
            PopupMenuButton<String>(
                icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                onSelected: (String value) {
                  searchTextController.text = value;
                  startSearch(searchTextController.text);
                },
                itemBuilder: (BuildContext context) {
                  return previousSearches
                      .map<CustomDropdownMediaItem<String>>((String value) {
                    return CustomDropdownMediaItem<String>(
                      text: value,
                      value: value,
                      callback: () {
                        setState(() {
                          previousSearches.remove(value);
                          savePreviousSearches();
                          Navigator.pop(context);
                        });
                      },
                    );
                  }).toList();
                })
          ],
        ),
      ),
    );
  }

  void startSearch(String value) {
    setState(() {
      currentSearchList.clear();
      currentCount = 0;
      currentEndPosition = pageCount;
      currentStartPosition = 0;
      hasMore = true;
      value = value.trim();

      if (!previousSearches.contains(value)) {
        previousSearches.add(value);
        savePreviousSearches();
      }
    });
  }

  // TODO: Replace method
  Widget _buildMediaLoader(BuildContext context) {
    if (searchTextController.text.length < 3) {
      return Container();
    }
    // Show a loading indicator while waiting for the movies
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  // TODO: Add _buildMediaCard
}
