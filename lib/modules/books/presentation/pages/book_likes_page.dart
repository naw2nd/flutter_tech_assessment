import 'package:flutter/material.dart';
import 'package:flutter_tech_assessment/core/router.dart';
import 'package:collection/collection.dart';
import 'package:flutter_tech_assessment/modules/books/presentation/providers/book_likes_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BookLikesPage extends StatefulWidget {
  const BookLikesPage({super.key});

  @override
  State<BookLikesPage> createState() => _BookLikesPageState();
}

class _BookLikesPageState extends State<BookLikesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<BookLikesProvider>().fetchBooks();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Likes')),
      body: Consumer<BookLikesProvider>(
        builder: (context, provider, child) => Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ...provider.books.map((book) {
                    return ListTile(
                      title: Text(book.title),
                      subtitle: Wrap(
                        children: [
                          ...book.author.mapIndexed((index, author) {
                            final text = (index == book.author.length - 1)
                                ? author
                                : '$author | ';
                            return Text(text);
                          }),
                        ],
                      ),
                      onTap: () {
                        context.push('${AppRouteConfig.books}/${book.id}');
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
