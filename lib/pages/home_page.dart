import 'package:flutter/material.dart';
import 'package:reader/components/gridview_widget.dart';
import 'package:reader/models/book.dart';
import 'package:reader/network/network.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Network network = Network();
  List<Book> _books = [];

  Future<void> _getBooks(String query) async {
    try {
      List<Book> books = await network.getBooks(query);
      setState(() {
        _books = books;
      });
      // ignore: empty_catches
    } catch (e) {}
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search a book',
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onSubmitted: (value) => _getBooks(value),
              ),
            ),
            GridViewWidget(books: _books),
          ],
        ),
      ),
    );
  }
}
