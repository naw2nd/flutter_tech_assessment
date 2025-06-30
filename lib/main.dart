import 'package:flutter/material.dart';
import 'package:flutter_tech_assessment/core/router.dart';
import 'package:flutter_tech_assessment/modules/books/presentation/providers/book_detail_provider.dart';
import 'package:flutter_tech_assessment/modules/books/presentation/providers/book_likes_provider.dart';
import 'package:flutter_tech_assessment/modules/books/presentation/providers/books_home_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BooksHomeProvider()),
        ChangeNotifierProvider(create: (context) => BookDetailProvider()),
        ChangeNotifierProvider(create: (context) => BookLikesProvider()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        routerConfig: AppRouteConfig.routes,
      ),
    );
  }
}
