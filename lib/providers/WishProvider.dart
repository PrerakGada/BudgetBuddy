import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class Wish {
  int id;
  String title;
  String time;
  String image;
  num reached;
  num goal;

  Wish({
    required this.id,
    required this.title,
    required this.time,
    required this.image,
    required this.reached,
    required this.goal,
  });
}

class WishProvider extends ChangeNotifier {
  List<Wish> _wish = [];

  WishProvider() {
    _getWish();
  }

  void _getWish() async {
    List<String> titles = [
      'New Home',
      'Go on a Vacation',
      'Buy a Phone',
      'Go to Sunburn Goa'
    ];
    Random random = Random();
    for (int i = 1; i <= 8; i++) {
      String title = titles[i % 4];
      num time = 1 + random.nextInt(3);
      num reached = 5000 + random.nextInt(5000);
      num goal = 15000 + random.nextInt(15000);
      Wish wish = Wish(
        id: i,
        title: title,
        time: "$time months left",
        image: "home.svg",
        reached: reached,
        goal: goal,
      );
      wishes.add(wish);
    }
    print(wishes);
  }

  List<Wish> get wishes => _wish;

  void addWish(Wish wish) {
    _wish.add(wish);
    notifyListeners();
  }
}
