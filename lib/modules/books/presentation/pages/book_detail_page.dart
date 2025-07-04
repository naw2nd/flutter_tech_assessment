import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_assessment/core/utils/data_state.dart';
import 'package:flutter_tech_assessment/core/utils/extension.dart';
import 'package:flutter_tech_assessment/modules/books/domain/entity/book_detail_entity.dart';
import 'package:flutter_tech_assessment/modules/books/presentation/providers/book_detail_provider.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

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
    return Consumer<BookDetailProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(title: Text('Details')),
          body: Container(
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(25)),
            ),
            child: Builder(
              builder: (context) {
                if (provider.state == DataState.loading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (provider.state == DataState.success &&
                    provider.bookDetail != null) {
                  final book = provider.bookDetail!;
                  return RefreshIndicator(
                    onRefresh: () async {
                      if (widget.bookId != null) {
                        await context
                            .read<BookDetailProvider>()
                            .fetchBookDetail(widget.bookId!);
                      }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ListView(
                          children: [
                            SizedBox(height: 20),
                            Center(child: BookDisplay(book: book)),
                            SizedBox(height: 20),
                            Text(
                              'Synopsis',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w900),
                            ),
                            SizedBox(height: 5),
                            ...book.summaries.map(
                              (e) => Text(
                                e,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: Colors.black54),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                      ),
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
                          if (widget.bookId != null) {
                            context.read<BookDetailProvider>().fetchBookDetail(
                              widget.bookId!,
                            );
                          }
                        },
                        child: Text('Refresh'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          floatingActionButton: provider.state == DataState.success
              ? FloatingActionButton(
                  child: Icon(
                    provider.isFav ? Icons.favorite : Icons.favorite_outline,
                  ),
                  onPressed: () async {
                    await provider.toggleFavoriteStatus();
                    String toastText = 'Added to likes';
                    if (!provider.isFav) {
                      toastText = 'Removed from likes';
                    }

                    if (!context.mounted) return;
                    toastification.show(
                      context: context,
                      icon: Icon(
                        provider.isFav
                            ? Icons.favorite
                            : Icons.favorite_outline,
                        color: Colors.deepPurple,
                      ),
                      title: Text(toastText),
                      autoCloseDuration: Duration(seconds: 1),
                    );
                  },
                )
              : null,
        );
      },
    );
  }
}

class BookDisplay extends StatelessWidget {
  const BookDisplay({super.key, required this.book});

  final BookDetailEntity book;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 120,
          height: 170,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 15),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ],
          ),
          child: book.imageUrl != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    book.imageUrl!,
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                )
              : null,
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                book.title,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: 'by '),
                    ...book.author.mapIndexed((index, value) {
                      return TextSpan(
                        children: [
                          TextSpan(
                            text: value,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          if (index < book.author.length - 1)
                            TextSpan(text: ' | '),
                        ],
                      );
                    }),
                  ],
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.download, color: Colors.green, size: 15),
                  SizedBox(width: 2),
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: book.downloads?.toAbbreviatedString()),
                          TextSpan(
                            text: ' Downloads',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: Colors.green),
                          ),
                        ],
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
