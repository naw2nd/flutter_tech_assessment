import 'package:equatable/equatable.dart';
import 'package:flutter_tech_assessment/modules/books/domain/entity/book_detail_entity.dart';
import 'package:flutter_tech_assessment/modules/books/domain/entity/book_entity.dart';

class BookResponse extends Equatable {
  final int? id;
  final String? title;
  final List<Author>? authors;
  final List<String>? summaries;
  final List<Author>? translators;
  final List<String>? subjects;
  final List<String>? bookshelves;
  final List<String>? languages;
  final bool? copyright;
  final String? mediaType;
  final Map<String, String>? formats;
  final int? downloadCount;

  const BookResponse({
    this.id,
    this.title,
    this.authors,
    this.summaries,
    this.translators,
    this.subjects,
    this.bookshelves,
    this.languages,
    this.copyright,
    this.mediaType,
    this.formats,
    this.downloadCount,
  });

  factory BookResponse.fromJson(Map<String, dynamic> json) {
    return BookResponse(
      id: json['id'],
      title: json['title'],
      authors: (json['authors'] as List)
          .map((item) => Author.fromJson(item))
          .toList(),
      summaries: List<String>.from(json['summaries']),
      translators: (json['translators'] as List)
          .map((item) => Author.fromJson(item))
          .toList(),
      subjects: List<String>.from(json['subjects']),
      bookshelves: List<String>.from(json['bookshelves']),
      languages: List<String>.from(json['languages']),
      copyright: json['copyright'],
      mediaType: json['media_type'],
      formats: Map<String, String>.from(json['formats']),
      downloadCount: json['download_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'authors': authors?.map((a) => a.toJson()).toList(),
      'summaries': summaries,
      'translators': translators?.map((a) => a.toJson()).toList(),
      'subjects': subjects,
      'bookshelves': bookshelves,
      'languages': languages,
      'copyright': copyright,
      'media_type': mediaType,
      'formats': formats,
      'download_count': downloadCount,
    };
  }

  BookEntity toEntity() {
    final List<String> allAuthors = [
      if (authors != null) ...authors!.map((a) => a.name),
    ];
    return BookEntity(
      id: id?.toString() ?? '<< No ID >>',
      title: title ?? '<< No Title >>',
      author: allAuthors,
      imageUrl: formats?['image/jpeg'],
    );
  }

  BookDetailEntity toDetailEntity() {
    final List<String> allAuthors = [
      if (authors != null) ...authors!.map((a) => a.name),
    ];

    return BookDetailEntity(
      id: id?.toString() ?? '<< No ID >>',
      title: title ?? '<< No Title >>',
      author: allAuthors,
      summaries: summaries ?? [],
      imageUrl: formats?['image/jpeg'],
      downloads: downloadCount,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    authors,
    summaries,
    translators,
    subjects,
    bookshelves,
    languages,
    copyright,
    mediaType,
    formats,
    downloadCount,
  ];
}

class Author extends Equatable {
  final String name;
  final int? birthYear;
  final int? deathYear;

  const Author({required this.name, this.birthYear, this.deathYear});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      name: json['name'],
      birthYear: json['birth_year'],
      deathYear: json['death_year'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'birth_year': birthYear, 'death_year': deathYear};
  }

  @override
  List<Object?> get props => [name, birthYear, deathYear];
}
