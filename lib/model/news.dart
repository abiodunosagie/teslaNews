import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class NewsArticle {
  final String sourceName;
  final String author;
  final String title;
  final String description;
  final String url;
  final String imageUrl;
  final DateTime publishedAt;
  final String content;

  // Add a getter for formatted publishedAt
  String get formattedPublishedAt {
    // Format the DateTime using DateFormat
    return DateFormat.yMMMMd().add_jm().format(publishedAt);
  }

  NewsArticle({
    required this.sourceName,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.publishedAt,
    required this.content,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      sourceName: json['source'] != null ? json['source']['name'] ?? '' : '',
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      imageUrl: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'] != null
          ? DateTime.parse(json['publishedAt'])
          : DateTime.now(),
      content: json['content'] ?? '',
    );
  }
}

class NewsService {
  static const String _baseUrl = 'https://newsapi.org/v2';
  static const String _apiKey =
      'f76fdcb7e4c440dc9422c0a8a4308211'; // Replace with your actual API key
  Future<List<NewsArticle>> fetchNews() async {
    final response = await http.get(Uri.parse(
        '$_baseUrl/everything?q=tesla&from=2024-04-02&sortBy=publishedAt&apiKey=$_apiKey'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> articlesJson = data['articles'];
      return articlesJson
          .map((articleJson) => NewsArticle.fromJson(articleJson))
          .toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
