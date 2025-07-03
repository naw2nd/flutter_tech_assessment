import 'package:flutter/material.dart';
import 'package:flutter_tech_assessment/core/router.dart';
import 'package:flutter_tech_assessment/core/service/api/api_client.dart';
import 'package:flutter_tech_assessment/core/service/storage/local_storage.dart';
import 'package:flutter_tech_assessment/modules/books/data/data_source/book_local_data_source.dart';
import 'package:flutter_tech_assessment/modules/books/data/data_source/book_remote_data_source.dart';
import 'package:flutter_tech_assessment/modules/books/data/repostory/book_repository.dart';
import 'package:flutter_tech_assessment/modules/books/domain/interface/book_interface.dart';
import 'package:flutter_tech_assessment/modules/books/presentation/providers/book_detail_provider.dart';
import 'package:flutter_tech_assessment/modules/books/presentation/providers/book_likes_provider.dart';
import 'package:flutter_tech_assessment/modules/books/presentation/providers/books_home_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localStorage = LocalStorage();
  await localStorage.init();

  runApp(MyApp(localStorage: localStorage));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.localStorage});
  final LocalStorage localStorage;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => ApiClient()),
        Provider(create: (context) => localStorage),
        Provider(
          create: (context) =>
              BookRemoteDataSourceImpl(apiClient: context.read())
                  as BookRemoteDataSource,
        ),
        Provider(
          create: (context) =>
              BookLocalDataSourceImpl(localStorage: context.read())
                  as BookLocalDataSource,
        ),
        Provider(
          create: (context) =>
              BookRepository(
                    remoteDataSource: context.read(),
                    localDataSource: context.read(),
                  )
                  as BookInterface,
        ),
        ChangeNotifierProvider(
          create: (context) => BooksHomeProvider(bookInterface: context.read()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              BookDetailProvider(bookInterface: context.read()),
        ),
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
