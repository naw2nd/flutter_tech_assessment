import 'package:equatable/equatable.dart';

class BookDetailEntity extends Equatable {
  final String id;
  final String title;
  final List<String> author;
  final List<String> summaries;
  final String? imageUrl;
  final bool isLiked;
  final int? downloads;

  const BookDetailEntity({
    required this.id,
    required this.title,
    required this.author,
    required this.summaries,
    this.imageUrl,
    this.downloads,
    this.isLiked = false,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    author,
    summaries,
    imageUrl,
    isLiked,
    downloads,
  ];
}
