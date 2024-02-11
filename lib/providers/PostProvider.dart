import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class Post {
  int id;
  String title;
  String time;
  String desc;

  Post({
    required this.id,
    required this.title,
    required this.time,
    required this.desc,
  });
}

class PostProvider extends ChangeNotifier {
  List<Post> _post = [];

  PostProvider() {
    _getPost();
  }

  void _getPost() async {
    List<String> titles = ['WishList', 'Saved', 'Task', 'Spendings'];
    List<String> descs = [
      'Today I finally bought my Car',
      'This month I saved extra ₹5000',
      'Yesterday I completed a task and got rewards',
      'This week I spent ₹5000 on joining a gym'
    ];
    Random random = Random();
    for (int i = 1; i <= 8; i++) {
      String title = titles[i % 4];
      num time = 1 + random.nextInt(40);
      String desc = descs[i % 4];
      Post post = Post(
        id: i,
        title: title,
        time: "$time months left",
        desc: desc,
      );
      postes.add(post);
    }
    print(postes);
  }

  List<Post> get postes => _post;
}
