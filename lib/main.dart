import 'package:flutter/material.dart';
import 'package:minichallenge3/models/profile_manager.dart';
import 'package:minichallenge3/models/user_manager.dart';
import 'package:provider/provider.dart';
import 'cinescreen_theme.dart';
import 'models/app_state_manager.dart';
import 'navigation/app_router.dart';

// Main entry point for the app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appStateManager = AppStateManager();
  await appStateManager.initializeApp();
  runApp(CineScreen(appStateManager: appStateManager));
}

// CineScreen is the root widget of the app
class CineScreen extends StatefulWidget {
  final AppStateManager appStateManager;

  const CineScreen({super.key, required this.appStateManager});

  @override
  FooderlichState createState() => FooderlichState();
}

class FooderlichState extends State<CineScreen> {
  late final _userManager = UserManager();
  late final _profileManager = ProfileManager();
  late final _appRouter = AppRouter(
    widget.appStateManager,
    _profileManager,
    _userManager,
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => _userManager,
        ),
        ChangeNotifierProvider(
          create: (context) => _profileManager,
        ),
        ChangeNotifierProvider(
          create: (context) => widget.appStateManager,
        ),
      ],
      child: Consumer<UserManager>(
        builder: (context, userManager, child) {
          ThemeData theme;
          if (userManager.darkMode) {
            theme = CineScreenTheme.dark();
          } else {
            theme = CineScreenTheme.light();
          }

          final router = _appRouter.router;
          return MaterialApp.router(
            theme: theme,
            title: 'CineScreen',
            routeInformationParser: router.routeInformationParser,
            routeInformationProvider: router.routeInformationProvider,
            routerDelegate: router.routerDelegate,
          );
        },
      ),
    );
  }
}
