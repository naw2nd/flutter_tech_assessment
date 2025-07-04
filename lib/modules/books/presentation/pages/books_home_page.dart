import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tech_assessment/core/utils/data_state.dart';
import 'package:flutter_tech_assessment/modules/books/presentation/providers/books_home_provider.dart';
import 'package:flutter_tech_assessment/modules/books/presentation/widgets/book_tile.dart';
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
      appBar: AppBar(leading: Icon(Icons.home), title: const Text('Home')),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<BooksHomeProvider>().fetchBooks();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 4),
                    child: Icon(Icons.search),
                  ),
                  prefixIconConstraints: BoxConstraints(),
                  hintText: 'Search',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  isDense: true,
                ),
                onChanged: (value) {
                  _onSearchChanged(value);
                },
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25)),
                ),
                child: Consumer<BooksHomeProvider>(
                  builder: (context, provider, child) {
                    if (provider.state == DataState.loading) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (provider.state == DataState.success) {
                      return ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: 5),
                          physics: AlwaysScrollableScrollPhysics(),
                          controller: _scrollController,
                          itemCount:
                              provider.books.length +
                              (provider.hasMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index < provider.books.length) {
                              final book = provider.books[index];
                              return BookTile(book: book);
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
