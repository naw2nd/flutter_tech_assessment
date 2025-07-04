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
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();

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
    _searchController.dispose();
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
                controller: _searchController,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  hintText: 'Search',
                  contentPadding: EdgeInsets.only(left: 20),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  isDense: true,
                ),
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
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

                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(provider.errorMessage),
                          // SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              _searchController.clear();
                              context.read<BooksHomeProvider>().fetchBooks();
                            },
                            child: Text('Refresh'),
                          ),
                        ],
                      ),
                    );
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
