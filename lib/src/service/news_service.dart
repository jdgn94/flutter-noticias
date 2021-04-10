import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/models/news_models.dart';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';
  bool _isLoading = true;

  List<Category> categories = [
    Category(icon: FontAwesomeIcons.building, name: 'business'),
    Category(icon: FontAwesomeIcons.tv, name: 'entertainment'),
    Category(icon: FontAwesomeIcons.addressCard, name: 'general'),
    Category(icon: FontAwesomeIcons.headSideVirus, name: 'health'),
    Category(icon: FontAwesomeIcons.vials, name: 'science'),
    Category(icon: FontAwesomeIcons.volleyballBall, name: 'sports'),
    Category(icon: FontAwesomeIcons.memory, name: 'technology'),
  ];

  Map<String, List<Article>> categoriesArticles = {};

  NewsService() {
    this.getTopHeadlines();

    categories.forEach((item) {
      this.categoriesArticles[item.name] = [];
    });
  }

  bool get isLoading => this._isLoading;

  final _urlBase = 'https://newsapi.org/v2';
  final _apiKey = '958a250d161c4e3295d363f62a8978fc';

  get selectedCategory => this._selectedCategory;

  set selectedCategory(String value) {
    this._selectedCategory = value;
    this._isLoading = true;
    this.getSelectedCategory(value);
    notifyListeners();
  }

  getTopHeadlines() async {
    final url = '$_urlBase/top-headlines?apiKey=$_apiKey&country=ve';
    final res = await http.get(url);
    final newsResponse = newsResponseFromJson(res.body);

    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getSelectedCategory(String category) async {
    if (this.categoriesArticles[category].length > 0) {
      this._isLoading = false;
      notifyListeners();
      return this.categoriesArticles[category];
    }

    final url =
        '$_urlBase/top-headlines?apiKey=$_apiKey&country=ve&category=$category';
    final res = await http.get(url);
    final newsResponse = newsResponseFromJson(res.body);

    this.categoriesArticles[category].addAll(newsResponse.articles);
    this._isLoading = false;
    notifyListeners();
  }

  List<Article> get getArticleCategorySelected =>
      this.categoriesArticles[this.selectedCategory];
}
