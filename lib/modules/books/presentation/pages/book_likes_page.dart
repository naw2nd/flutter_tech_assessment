import 'package:flutter/material.dart';
import 'package:flutter_tech_assessment/core/utils/data_state.dart';
import 'package:flutter_tech_assessment/modules/books/presentation/providers/book_likes_provider.dart';
import 'package:flutter_tech_assessment/modules/books/presentation/widgets/book_tile.dart';
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
      appBar: AppBar(leading: Icon(Icons.favorite), title: const Text('Likes')),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<BookLikesProvider>().fetchBooks();
        },
        child: Container(
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(25)),
          ),
          child: Consumer<BookLikesProvider>(
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
                    physics: AlwaysScrollableScrollPhysics(),
                    controller: _scrollController,
                    itemCount:
                        provider.favBooks.length + (provider.hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < provider.favBooks.length) {
                        final book = provider.favBooks[index];
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
    );
  }
}
