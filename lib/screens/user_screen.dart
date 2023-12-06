import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minichallenge3/models/profile_manager.dart';
import 'package:minichallenge3/models/user_manager.dart';
import 'package:provider/provider.dart';

import '../widgets/circle_image.dart';
import '../models/user.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';

class UserScreen extends StatefulWidget {
  final User user;
  final int currentTab;
  const UserScreen({super.key, required this.user, required this.currentTab});

  @override
  UserScreenState createState() => UserScreenState();
}

class UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16.0),
            buildProfile(),
            Expanded(
              child: buildMenu(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMenu() {
    return ListView(
      children: [
        Text("Username @movielover3", style: GoogleFonts.aBeeZee(fontSize: 25)),
        const SizedBox(height: 16),
        buildDarkModeRow(),
        ListTile(
          title: const Text('Country:'),
          onTap: () {
            // TODO: Edit Country
          },
        ),
        ListTile(
          title: const Text('Language:'),
          onTap: () {
            // TODO: Edit Language
          },
        ),
        ListTile(
          title: const Text('Subscriptions:'),
          onTap: () {
            // TODO: Subscriptions
          },
        )
      ],
    );
  }

  Widget buildDarkModeRow() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Dark Mode'),
          Switch(
            value: widget.user.darkMode,
            onChanged: (value) {
              Provider.of<UserManager>(context, listen: false).darkMode = value;
            },
          )
        ],
      ),
    );
  }

  Widget buildProfile() {
    return Column(
      children: [
        CircleImage(
          imageProvider: AssetImage(widget.user.profileImageUrl),
          imageRadius: 60.0,
        ),
        const SizedBox(height: 16.0),
        Text(
          'Username: @${widget.user.userName}',
          style: const TextStyle(
            fontSize: 30,
            color: Colors.green,
          ),
        ),
        Text(
          widget.user.firstName,
          style: const TextStyle(
            fontSize: 21,
          ),
        ),
        Text(
          '${widget.user.country} is your home country',
          style: const TextStyle(
            fontSize: 30,
            color: Colors.green,
          ),
        ),
        Text(
          '${widget.user.language} is your default language',
          style: const TextStyle(
            fontSize: 30,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}
