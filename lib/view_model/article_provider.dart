import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:healio/model/article_model.dart';
import 'package:http/http.dart' as http;

class ArticleViewModel extends ChangeNotifier {
  final String baseUrl = 'http://192.168.1.7:3000/articles';
  List<Article> articles = [];
  bool isLoading = false;

  Future<void> fetchArticles() async {
    try {
      // Set loading state to true when fetching begins
      isLoading = true;
      // Notify listeners about the loading state change
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });

      final response = await http.get(Uri.parse(baseUrl));

      // Check if the response is successful
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        articles = data.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (error) {
      // Handle error and print it
      print(error);
    } finally {
      // Set loading to false after fetch attempt (whether successful or not)
      isLoading = false;
      // Notify listeners that the loading has finished
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }
}
