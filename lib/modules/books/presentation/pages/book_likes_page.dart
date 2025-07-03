import 'package:flutter/material.dart';
import 'package:flutter_tech_assessment/core/router.dart';
import 'package:collection/collection.dart';
import 'package:flutter_tech_assessment/core/utils/data_state.dart';
import 'package:flutter_tech_assessment/modules/books/presentation/providers/book_likes_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BookLikesPage extends StatefulWidget {
  const BookLikesPage({super.key});

  @override
  State<BookLikesPage> createState() => _BookLikesPageState();
}

class _BookLikesPageState extends State<BookLikesPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      if (mounted) {
        await context.read<BookLikesProvider>().fetchBooks();
      }
    });

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final provider = context.read<BookLikesProvider>();
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      provider.fetchMoreBook();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Likes')),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<BookLikesProvider>().fetchBooks();
        },
        child: Consumer<BookLikesProvider>(
          builder: (context, provider, child) {
            if (provider.state == DataState.loading) {
              return Center(child: CircularProgressIndicator());
            }

            if (provider.state == DataState.success) {
              return ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                itemCount:
                    provider.favBooks.length + (provider.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < provider.favBooks.length) {
                    final book = provider.favBooks[index];
                    return ListTile(
                      title: Text(book.title),
                      subtitle: Wrap(
                        children: [
                          ...book.author.mapIndexed((i, author) {
                            final text = (i == book.author.length - 1)
                                ? author
                                : '$author | ';
                            return Text(text);
                          }),
                        ],
                      ),
                      onTap: () async {
                        await context.push(
                          '${AppRouteConfig.books}/${book.id}',
                        );
                        await provider.fetchBooks();
                      },
                    );
                  } else {
                    // Show loading indicator at the bottom
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              );
            }

            if (provider.state == DataState.error) {
              return Text(provider.errorMessage);
            }

            return Container();
          },
        ),
      ),
    );
  }
}
