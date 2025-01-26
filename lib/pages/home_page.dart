import 'package:flutter/material.dart';
import 'package:reader/models/book.dart';
import 'package:reader/network/network.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Book> _books = [];
  Network network = Network();

  Future<void> _getBooks(String query) async {
    try {
      List<Book> books = await network.getBooks(query);
      setState(() {
        _books = books;
      });
    } catch (e) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reader'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search',
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onSubmitted: (value) => _getBooks(value),
              ),
            ),
            // GridViewWidget(books: _books),
            Expanded(
                child: SizedBox(
                    width: double.infinity,
                    child: ListView.builder(
                        itemCount: _books.length,
                        itemBuilder: (context, index) {
                          Book book = _books[index];
                          return ListTile(
                            title: Text(book.title),
                          );
                        })))
          ],
        ),
      ),
    );
  }
}
