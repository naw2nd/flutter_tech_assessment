import 'package:equatable/equatable.dart';

class BookEntity extends Equatable {
  final String id;
  final String title;
  final List<String> author;
  final String? imageUrl;

  const BookEntity({
    required this.id,
    required this.title,
    required this.author,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [id, title, author, imageUrl];

  String get authorString => author.join(' | ');
}
