import 'package:flutter/material.dart';
import 'package:flutter_tech_assessment/core/router.dart';
import 'package:flutter_tech_assessment/modules/books/domain/entity/book_entity.dart';
import 'package:go_router/go_router.dart';

class BookTile extends StatelessWidget {
  const BookTile({super.key, required this.book});

  final BookEntity book;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            leading: Container(
              width: 60,
              height: 60,
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
            title: Text(
              book.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            subtitle: RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'by ',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  TextSpan(
                    text: book.authorString,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            onTap: () {
              context.push('${AppRouteConfig.books}/${book.id}');
            },
          ),
        ),
        Container(height: 5, color: Colors.grey.shade200),
      ],
    );
  }
}
