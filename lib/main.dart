import 'package:flutter/material.dart';
import 'package:news_app/src/pages/tabs_page.dart';
import 'package:news_app/src/service/news_service.dart';

import 'package:news_app/src/theme/theme_dark.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => new NewsService())],
      child: MaterialApp(
        title: 'Material App',
        theme: themeDart,
        debugShowCheckedModeBanner: false,
        home: TabsPage(),
      ),
    );
  }
}
