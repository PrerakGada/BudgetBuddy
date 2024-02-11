import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class News {
  int id;
  String title;
  String description;
  String image;
  String url;
  String author;

  News({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.url,
    required this.author,
  });

  // write a from json function for this model
  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['urlToImage'],
      url: json['url'],
      author: json['author'],
    );
  }
}

class NewsProvider extends ChangeNotifier {
  List<News> _news = [];

  NewsProvider() {
    _getNews();
  }

  void _getNews() async {
    Response response = await get(Uri.parse(
        'https://innovative-minds.mustansirg.in/codeshastra/api/news/'));
    // print(response.body);
    var news = json.decode(response.body);
    for (var n in news) {
      _news.add(News.fromJson(n));
    }
  }

  List<News> get news => _news;
}
