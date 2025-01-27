import 'package:flutter/material.dart';
import 'package:reader/db/db_helper.dart';
import 'package:reader/models/book.dart';
import 'package:reader/utils/book_details_arguments.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
          future: DbHelper.instance.readAllBooks(),
          builder: (context, snapshot) => snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Book book = snapshot.data![index];
                    return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/details',
                              arguments: BookDetailsArguments(
                                  itemBook: book, isSaved: true));
                        },
                        child: Card(
                            child: ListTile(
                          leading: Image.network(
                            book.imageLinks['thumbnail'] ?? '',
                            fit: BoxFit.cover,
                          ),
                          title: Text(book.title),
                          subtitle: Column(
                            children: [
                              // Text(book.authors.join(', ')),
                              ElevatedButton.icon(
                                onPressed: () async {
                                  book.isFavorite = !book.isFavorite;
                                  await DbHelper.instance
                                      .toggleFavorite(book.id, book.isFavorite);
                                  setState(() {});
                                },
                                icon: Icon(
                                  book.isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  color: book.isFavorite ? Colors.red : null,
                                ),
                                label: Text((book.isFavorite)
                                    ? 'Favorite'
                                    : 'Add to Favorites'),
                              ),
                            ],
                          ),
                        )));
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }
}
