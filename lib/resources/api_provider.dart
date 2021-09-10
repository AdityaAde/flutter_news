import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp/models/news_models.dart';
import 'package:newsapp/models/trending_news.dart';

class ApiProvider {
  Future<NewsModel> everythingNewsApi() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://newsapi.org/v2/everything?q=keyword&apiKey=81191b2e1dd7432eba657a8c06b21b05'),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return NewsModel.fromJson(result);
      } else {
        print('error get data');
      }
    } catch (e) {
      print('error di api provider $e');
    }
    return NewsModel();
  }

  Future<TrendingNewsModel> trendingNewsApi() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=81191b2e1dd7432eba657a8c06b21b05'),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print('trending ' + result['status']);
        return TrendingNewsModel.fromJson(result);
      } else {
        print('error get data');
      }
    } catch (e) {
      print('error di api provider $e');
    }
    return TrendingNewsModel();
  }
}
