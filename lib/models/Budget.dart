import 'package:flutter/material.dart';

class Category {
  String name;
  IconData icon;
  
  Category({required this.name, required this.icon});
}

class Transaction {
  String name;
  double amount;
  DateTime date;
  String category;
  
  Transaction({required this.name, required this.amount, required this.date, required this.category});
}

class Budget {
  String name;
  double amount;
  String month;
  List<Transaction> transactions;
  
  Budget({required this.name, required this.amount, required this.transactions, required this.month});
}

class Wish {
  String name;
  double amount;
  DateTime date;
  bool isCompleted;
  
  Wish({required this.name, required this.amount, required this.date, required this.isCompleted});
}

class Offer {
  String name;
  String description;
  String imageUrl;
  String code;
  
  Offer({required this.name, required this.description, required this.imageUrl, required this.code});
}

class Coupon {
  String name;
  String description;
  String imageUrl;
  String code;
  
  Coupon({required this.name, required this.description, required this.imageUrl, required this.code});
}