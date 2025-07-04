import 'dart:convert';
import 'dart:io';

import 'package:flutter_tech_assessment/core/base/entity/base_list_result_entity.dart';
import 'package:flutter_tech_assessment/core/base/response/base_list_response.dart';
import 'package:flutter_tech_assessment/modules/books/data/response/books_response.dart';
import 'package:flutter_tech_assessment/modules/books/domain/entity/book_detail_entity.dart';
import 'package:flutter_tech_assessment/modules/books/domain/entity/book_entity.dart';

class BooksTestData {
  static final jsonMapResult = jsonDecode(
    _readJson('test_data/books_test_data.json'),
  );

  static String _readJson(String name) {
    return File('./test/fakes/$name').readAsStringSync();
  }

  static final bookFavoriteIds = bookResponses
      .map((e) => e.id)
      .whereType<int>()
      .toList();
  static final bookFavoriteIdsString = jsonEncode(bookFavoriteIds);

  static final List<BookResponse> bookResponses = [
    BookResponse(
      id: 1,
      title: '1984',
      authors: [
        const Author(name: 'George Orwell', birthYear: 1903, deathYear: 1950),
      ],
      summaries: ['A dystopian novel set in Airstrip One.'],
      translators: [],
      subjects: ['Dystopia', 'Totalitarianism'],
      bookshelves: ['Classics'],
      languages: ['en'],
      copyright: false,
      mediaType: 'Text',
      formats: {'text/plain': 'https://example.com/1984.txt'},
      downloadCount: 1000,
    ),
    BookResponse(
      id: 2,
      title: 'To Kill a Mockingbird',
      authors: [
        const Author(name: 'Harper Lee', birthYear: 1926, deathYear: 2016),
      ],
      summaries: ['A novel about racial injustice in the Deep South.'],
      translators: [],
      subjects: ['Racism', 'Justice'],
      bookshelves: ['Classics'],
      languages: ['en'],
      copyright: false,
      mediaType: 'Text',
      formats: {'text/plain': 'https://example.com/mockingbird.txt'},
      downloadCount: 900,
    ),
    BookResponse(
      id: 3,
      title: 'The Great Gatsby',
      authors: [
        const Author(
          name: 'F. Scott Fitzgerald',
          birthYear: 1896,
          deathYear: 1940,
        ),
      ],
      summaries: ['A story of the Jazz Age in the United States.'],
      translators: [],
      subjects: ['Wealth', 'Love'],
      bookshelves: ['Classics'],
      languages: ['en'],
      copyright: false,
      mediaType: 'Text',
      formats: {'text/plain': 'https://example.com/gatsby.txt'},
      downloadCount: 800,
    ),
    BookResponse(
      id: 4,
      title: 'Pride and Prejudice',
      authors: [
        const Author(name: 'Jane Austen', birthYear: 1775, deathYear: 1817),
      ],
      summaries: ['A romantic novel of manners.'],
      translators: [],
      subjects: ['Romance', 'Society'],
      bookshelves: ['Classics'],
      languages: ['en'],
      copyright: false,
      mediaType: 'Text',
      formats: {'text/plain': 'https://example.com/pride.txt'},
      downloadCount: 700,
    ),
    BookResponse(
      id: 5,
      title: 'Moby Dick',
      authors: [
        const Author(name: 'Herman Melville', birthYear: 1819, deathYear: 1891),
      ],
      summaries: ['A story of a giant whale and revenge.'],
      translators: [],
      subjects: ['Adventure', 'Sea'],
      bookshelves: ['Classics'],
      languages: ['en'],
      copyright: false,
      mediaType: 'Text',
      formats: {'text/plain': 'https://example.com/mobydick.txt'},
      downloadCount: 600,
    ),
  ];

  static final BaseListResponse<BookResponse> baseListBookResponses =
      BaseListResponse(
        count: 5,
        next: 'http://gutendex.com/books/?page=2&title=Frankenstein',
        previous: null,
        results: bookResponses,
      );

  static final listBookEntities = [
    BookEntity(id: '1', title: '1984', author: ['George Orwell']),
    BookEntity(id: '2', title: 'To Kill a Mockingbird', author: ['Harper Lee']),
    BookEntity(
      id: '3',
      title: 'The Great Gatsby',
      author: ['F. Scott Fitzgerald'],
    ),
    BookEntity(id: '4', title: 'Pride and Prejudice', author: ['Jane Austen']),
    BookEntity(id: '5', title: 'Moby Dick', author: ['Herman Melville']),
  ];

  static final BaseListResultEntity<BookEntity> baseListBookEntities =
      BaseListResultEntity<BookEntity>(
        count: 5,
        page: 1,
        results: listBookEntities,
      );

  static final listBookDetailEntities = [
    BookDetailEntity(
      id: '1',
      title: '1984',
      author: ['George Orwell'],
      summaries: ['A dystopian novel set in Airstrip One.'],
      imageUrl: null,
      downloads: 1000,
      isLiked: false,
    ),
    BookDetailEntity(
      id: '2',
      title: 'To Kill a Mockingbird',
      author: ['Harper Lee'],
      summaries: ['A novel about racial injustice in the Deep South.'],
      imageUrl: null,
      downloads: 900,
      isLiked: false,
    ),
    BookDetailEntity(
      id: '3',
      title: 'The Great Gatsby',
      author: ['F. Scott Fitzgerald'],
      summaries: ['A story of the Jazz Age in the United States.'],
      imageUrl: null,
      isLiked: false,
    ),
    BookDetailEntity(
      id: '4',
      title: 'Pride and Prejudice',
      author: ['Jane Austen'],
      summaries: ['A romantic novel of manners.'],
      imageUrl: null,
      downloads: 800,
      isLiked: false,
    ),
    BookDetailEntity(
      id: '5',
      title: 'Moby Dick',
      author: ['Herman Melville'],
      summaries: ['A story of a giant whale and revenge.'],
      imageUrl: null,
      downloads: 700,
      isLiked: false,
    ),
  ];

  static final BaseListResultEntity<BookDetailEntity>
  baseListBookDetailEntities = BaseListResultEntity<BookDetailEntity>(
    count: 5,
    page: 1,
    results: listBookDetailEntities,
  );
}
