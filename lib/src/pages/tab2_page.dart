import 'package:flutter/material.dart';
import 'package:news_app/src/models/category_model.dart';

import 'package:news_app/src/service/news_service.dart';
import 'package:news_app/src/widgets/list_news.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _ListCategories(),
            if (!newsService.isLoading)
              Expanded(child: ListNews(newsService.getArticleCategorySelected))
            else
              Expanded(child: Center(child: CircularProgressIndicator()))
          ],
        ),
      ),
    );
  }
}

class _ListCategories extends StatelessWidget {
  const _ListCategories({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final name = categories[index].name;
          return Container(
            width: 95.0,
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                _CategoryIcon(category: categories[index]),
                SizedBox(height: 5.0),
                Text('${name[0].toUpperCase()}${name.substring(1)}')
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryIcon extends StatelessWidget {
  const _CategoryIcon({
    Key key,
    @required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    final services = Provider.of<NewsService>(context);
    return GestureDetector(
      onTap: () {
        // print('${category.name}');
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = category.name;
      },
      child: Container(
        height: 40.0,
        width: 40.0,
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: Icon(
          category.icon,
          color: services.selectedCategory == category.name
              ? Theme.of(context).accentColor
              : Colors.black54,
        ),
      ),
    );
  }
}
