import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tech_assessment/core/router.dart';
import 'package:collection/collection.dart';
import 'package:flutter_tech_assessment/core/utils/data_state.dart';
import 'package:flutter_tech_assessment/modules/books/presentation/providers/books_home_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BooksHomePage extends StatefulWidget {
  const BooksHomePage({super.key});

  @override
  State<BooksHomePage> createState() => _BooksHomePageState();
}

class _BooksHomePageState extends State<BooksHomePage> {
  Timer? _debounce;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<BooksHomeProvider>().fetchBooks();
      }
    });

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final provider = context.read<BooksHomeProvider>();
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      provider.fetchMoreBook();
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      context.read<BooksHomeProvider>().fetchBooks(search: value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<BooksHomeProvider>().fetchBooks();
        },
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _onSearchChanged(value);
              },
            ),
            Consumer<BooksHomeProvider>(
              builder: (context, provider, child) {
                if (provider.state == DataState.loading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (provider.state == DataState.success) {
                  return Expanded(
                    child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: _scrollController,
                      itemCount:
                          provider.books.length + (provider.hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < provider.books.length) {
                          final book = provider.books[index];
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
                            onTap: () {
                              context.push(
                                '${AppRouteConfig.books}/${book.id}',
                              );
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
                    ),
                  );
                }

                if (provider.state == DataState.error) {
                  return Text(provider.errorMessage);
                }

                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
