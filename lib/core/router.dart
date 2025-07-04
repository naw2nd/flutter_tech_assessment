import 'package:flutter/material.dart';
import 'package:flutter_tech_assessment/modules/books/presentation/pages/book_detail_page.dart';
import 'package:flutter_tech_assessment/modules/books/presentation/pages/book_likes_page.dart';
import 'package:flutter_tech_assessment/modules/books/presentation/pages/books_home_page.dart';
import 'package:go_router/go_router.dart';

class AppRouteConfig {
  static const String books = '/books';
  static const String bookDetail = '/books/:bookId';
  static const String likes = '/likes';

  static GoRouter routes = GoRouter(
    initialLocation: books,
    routes: [
      ShellRoute(
        builder: (context, state, child) => Scaffold(
          body: child,
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  spreadRadius: 2,
                  blurRadius: 10,
                ),
              ],
            ),
            child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_outline),
                  label: 'Likes',
                ),
              ],
              currentIndex: state.uri.path == books ? 0 : 1,
              onTap: (index) {
                switch (index) {
                  case 0:
                    context.go(books);
                    break;
                  case 1:
                    context.go(likes);
                    break;
                }
              },
            ),
          ),
        ),
        routes: [
          GoRoute(
            path: books,
            builder: (context, state) => const BooksHomePage(),
          ),
          GoRoute(
            path: likes,
            builder: (context, state) => const BookLikesPage(),
          ),
        ],
      ),
      GoRoute(
        path: bookDetail,
        builder: (context, state) =>
            BookDetailPage(bookId: state.pathParameters['bookId']),
      ),
    ],
  );
}
