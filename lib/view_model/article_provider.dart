import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:healio/model/article_model.dart';
import 'package:http/http.dart' as http;

class ArticleViewModel extends ChangeNotifier {
  final String baseUrl = 'http://192.168.1.7:3000/api/content/articles';
  List<Article> articles = [];

  Future<void> fetchArticles() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        articles = data.map((json) => Article.fromJson(json)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (error) {
      print(error);
    }
  }
}
