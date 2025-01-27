import 'package:flutter/material.dart';
import 'package:reader/models/book.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({super.key, required List<Book> books}) : _books = books;

  final List<Book> _books;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.builder(
            itemCount: _books.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
            ),
            itemBuilder: (context, index) {
              Book book = _books[index];
              return Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0),
                    )),
                child: GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      // Book cover
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            book.imageLinks['thumbnail'] ?? '',
                            scale: 1.2,
                          )),
                      // Book title
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          book.title,
                          style: Theme.of(context).textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Book author
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            book.authors.join(', & '),
                            style: Theme.of(context).textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ))
                    ],
                  ),
                ),
              );
            }));
  }
}
