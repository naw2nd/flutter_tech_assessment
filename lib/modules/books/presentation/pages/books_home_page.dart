import 'package:flutter/material.dart';
import 'package:flutter_tech_assessment/core/router.dart';
import 'package:collection/collection.dart';
import 'package:flutter_tech_assessment/modules/books/presentation/providers/books_home_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BooksHomePage extends StatefulWidget {
  const BooksHomePage({super.key});

  @override
  State<BooksHomePage> createState() => _BooksHomePageState();
}

class _BooksHomePageState extends State<BooksHomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<BooksHomeProvider>().fetchBooks();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Consumer<BooksHomeProvider>(
        builder: (context, provider, child) => Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                provider.searchBooks(value);
              },
            ),
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
