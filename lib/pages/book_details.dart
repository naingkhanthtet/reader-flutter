import 'package:flutter/material.dart';
import 'package:reader/db/db_helper.dart';
import 'package:reader/models/book.dart';
import 'package:reader/utils/book_details_arguments.dart';

class BookDetailsPage extends StatefulWidget {
  const BookDetailsPage({super.key});

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as BookDetailsArguments;
    final Book book = args.itemBook;
    final bool isSaved = args.isSaved;

    return Scaffold(
        appBar: AppBar(
          title: Text(book.title),
        ),
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            children: [
              // Book cover image
              if (book.imageLinks.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    book.imageLinks['thumbnail'] ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              // Book details
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    book.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(book.authors.join(', ')),
                  Text('Published: ${book.publishedDate}'),
                  Text('Page count: ${book.pageCount}'),
                  Text('Language: ${book.language}'),
                  // Save & Favorite buttons
                  SizedBox(
                    // Save button
                    child: !isSaved
                        ? ElevatedButton(
                            onPressed: () async {
                              try {
                                // Save book
                                int savedInt =
                                    await DbHelper.instance.insert(book);
                                SnackBar snackBar = SnackBar(
                                  content: Text('Book saved'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } catch (e) {
                                print('Error: $e');
                              }
                            },
                            child: const Text('Save'),
                          )
                        : ElevatedButton.icon(
                            onPressed: () async {},
                            icon: const Icon(Icons.favorite),
                            label: const Text('Favorite'),
                          ),
                  ),
                  // Book description
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: Text(book.description),
                  )
                ],
              )
            ],
          ),
        )));
  }
}
