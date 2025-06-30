class BookDetailEntity {
  final String id;
  final String title;
  final List<String> author;
  final List<String> summaries;
  final String? imageUrl;
  final bool isLiked;

  BookDetailEntity({
    required this.id,
    required this.title,
    required this.author,
    required this.summaries,
    this.imageUrl,
    this.isLiked = false,
  });
}
