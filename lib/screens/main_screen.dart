import 'package:bmp_music/screens/home_screen.dart';
import 'package:bmp_music/screens/library_screen.dart';
import 'package:bmp_music/screens/search_screen.dart';
import 'package:bmp_music/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const LibraryScreen(),
    const SearchScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor:
            Theme.of(context).navigationBarTheme.backgroundColor,
        systemNavigationBarIconBrightness:
            Theme.of(context).brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
      ),
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Offstage(
              offstage: _selectedIndex != 0,
              child: _screens[0],
            ),
            Offstage(
              offstage: _selectedIndex != 1,
              child: _screens[1],
            ),
            Offstage(
              offstage: _selectedIndex != 2,
              child: _screens[2],
            ),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (value) => setState(() {
            _selectedIndex = value;
          }),
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.home_rounded),
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.library_music_rounded),
              icon: Icon(Icons.library_music_outlined),
              label: "Library",
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.search_rounded),
              icon: Icon(Icons.search_rounded),
              label: "Search",
            ),
          ],
        ),
      ),
    );
  }
}
