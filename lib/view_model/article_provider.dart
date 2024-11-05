import 'package:flutter/material.dart';
import 'package:healio/model/article_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ArticleProvider with ChangeNotifier {
  List<Article> _articles = [];

  List<Article> get articles => _articles;

  // Fetch articles from the API
  Future<void> fetchArticles() async {
    final url = Uri.parse(
        'https://medicationsapi-production.up.railway.app/api/articles');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _articles = data.map((item) => Article.fromJson(item)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (error) {
      print('Error fetching articles: $error');
    }
  }
}
