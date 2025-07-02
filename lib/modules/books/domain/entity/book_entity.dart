import 'package:equatable/equatable.dart';

class BookEntity extends Equatable {
  final String id;
  final String title;
  final List<String> author;

  const BookEntity({
    required this.id,
    required this.title,
    required this.author,
  });

  @override
  List<Object?> get props => [id, title, author];
}
