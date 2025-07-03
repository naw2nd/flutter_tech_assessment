import 'package:flutter/material.dart';
import 'package:flutter_tech_assessment/core/utils/data_state.dart';
import 'package:flutter_tech_assessment/modules/books/presentation/providers/book_detail_provider.dart';
import 'package:provider/provider.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({super.key, required this.bookId});

  final String? bookId;

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        if (widget.bookId != null) {
          context.read<BookDetailProvider>().fetchBookDetail(widget.bookId!);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BookDetailProvider>(
        builder: (context, provider, child) {
          if (provider.state == DataState.loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (provider.state == DataState.success &&
              provider.bookDetail != null) {
            final book = provider.bookDetail!;
            return RefreshIndicator(
              onRefresh: () async {
                if (widget.bookId != null) {
                  await context.read<BookDetailProvider>().fetchBookDetail(
                    widget.bookId!,
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Container(
                      height: 200,
                      color: Colors.blueGrey[100],
                      child: Center(
                        child: Text(
                          book.title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Text(book.title),
                    Wrap(
                      children: [
                        ...book.author.map((author) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ),
                            child: Chip(
                              label: Text(author),
                              backgroundColor: Colors.blue[100],
                            ),
                          );
                        }),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        provider.toggleFavoriteStatus();
                      },
                      icon: Icon(
                        provider.isFav
                            ? Icons.favorite
                            : Icons.favorite_outline,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (provider.state == DataState.error) {
            return Center(child: Text(provider.errorMessage));
          }

          return Container();
        },
      ),
    );
  }
}
