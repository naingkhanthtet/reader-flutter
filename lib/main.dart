import 'package:flutter/material.dart';
import 'package:reader/models/book.dart';
import 'package:reader/network/network.dart';
import 'package:reader/pages/favorite_page.dart';
import 'package:reader/pages/home_page.dart';
import 'package:reader/pages/saved_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reader App',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true),
      initialRoute: '/',
      routes: {
        '/home': (context) => const HomePage(),
        '/favorite': (context) => const FavoritePage(),
        '/saved': (context) => const SavedPage(),
      },
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    const FavoritePage(),
    const SavedPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reader'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.save),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        selectedItemColor: Theme.of(context).colorScheme.onInverseSurface,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}
