import 'package:flutter/material.dart';
import 'package:flutter_tech_assessment/modules/books/domain/entity/book_entity.dart';

class BooksHomeProvider extends ChangeNotifier {
  List<BookEntity> books = [];

  void fetchBooks() {
    books = _sampleBooks();
    notifyListeners();
  }

  void searchBooks(String query) {
    if (query.isEmpty) {
      books = _sampleBooks();
    } else {
      books = _sampleBooks()
          .where(
            (book) => book.title.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
    notifyListeners();
  }

  List<BookEntity> _sampleBooks() {
    return [
      BookEntity(id: '1', title: '1984', author: ['George Orwell']),
      BookEntity(
        id: '2',
        title: 'To Kill a Mockingbird',
        author: ['Harper Lee'],
      ),
      BookEntity(
        id: '3',
        title: 'The Great Gatsby',
        author: ['F. Scott Fitzgerald'],
      ),
      BookEntity(
        id: '4',
        title: 'Pride and Prejudice',
        author: ['Jane Austen'],
      ),
      BookEntity(id: '5', title: 'Moby Dick', author: ['Herman Melville']),
      BookEntity(id: '6', title: 'War and Peace', author: ['Leo Tolstoy']),
      BookEntity(
        id: '7',
        title: 'The Catcher in the Rye',
        author: ['J.D. Salinger'],
      ),
      BookEntity(id: '8', title: 'The Hobbit', author: ['J.R.R. Tolkien']),
      BookEntity(id: '9', title: 'Brave New World', author: ['Aldous Huxley']),
      BookEntity(
        id: '10',
        title: 'Crime and Punishment',
        author: ['Fyodor Dostoevsky'],
      ),
      BookEntity(id: '11', title: 'The Odyssey', author: ['Homer']),
      BookEntity(
        id: '12',
        title: 'The Brothers Karamazov',
        author: ['Fyodor Dostoevsky'],
      ),
      BookEntity(id: '13', title: 'Jane Eyre', author: ['Charlotte Brontë']),
      BookEntity(
        id: '14',
        title: 'Wuthering Heights',
        author: ['Emily Brontë'],
      ),
      BookEntity(id: '15', title: 'Animal Farm', author: ['George Orwell']),
      BookEntity(
        id: '16',
        title: 'The Lord of the Rings',
        author: ['J.R.R. Tolkien'],
      ),
      BookEntity(
        id: '17',
        title: 'Great Expectations',
        author: ['Charles Dickens'],
      ),
      // Buku dengan lebih dari satu author
      BookEntity(
        id: '18',
        title: 'The Divine Comedy',
        author: ['Dante Alighieri', 'Translator: Allen Mandelbaum'],
      ),
      BookEntity(
        id: '19',
        title: 'Don Quixote',
        author: ['Miguel de Cervantes', 'Translator: Edith Grossman'],
      ),
      BookEntity(
        id: '20',
        title: 'Les Misérables',
        author: ['Victor Hugo', 'Translator: Norman Denny'],
      ),
    ];
  }
}
