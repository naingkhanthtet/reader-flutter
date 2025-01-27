import 'package:reader/models/book.dart';

class BookDetailsArguments {
  final Book itemBook;
  final bool isSaved;

  BookDetailsArguments({
    required this.itemBook,
    required this.isSaved,
  });
}
