import 'package:flutter/material.dart';
import 'package:reader/db/db_helper.dart';
import 'package:reader/models/book.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
          future: DbHelper.instance.getFavorites(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              List<Book> favBooks = snapshot.data!;
              return ListView.builder(
                itemCount: favBooks.length,
                itemBuilder: (context, index) {
                  Book book = favBooks[index];
                  return Card(
                      child: ListTile(
                    leading: Image.network(
                      book.imageLinks['thumbnail'] ?? '',
                      fit: BoxFit.cover,
                    ),
                    title: Text(book.title),
                    subtitle: Text(book.authors.join(', ')),
                    trailing: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  ));
                },
              );
            } else {
              return const Center(
                child: Text('No favorites yet'),
              );
            }
          },
        ));
  }
}
