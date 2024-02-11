import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../models/Budget.dart';
import '../models/User.dart';
import '../utils/api_url.dart';
import '../utils/shared_preference.dart';

class BudgetProvider extends ChangeNotifier {
  List<Budget> _budgets = [];

  BudgetProvider() {
    getBudgets();
  }

  void getBudgets() {
    Random random = Random();
    var categories = ['Health', 'Food', 'Lifestyle', 'Travel', 'Education'];
    List<String> transactionNames = [
      'Gasoline',
      'Grocery Store',
      'Movie Theater',
      'Car Wash',
      'Gym Membership',
      'Clothing Store',
      'Pharmacy',
      'Hair Salon',
      'Restaurant',
      'Supermarket',
      'Coffee Shop',
      'Electronics Store',
      'Public Transportation',
      'Bookstore',
      'Convenience Store',
      'Dry Cleaning',
    ];

    for (int i = 1; i <= 6; i++) {
      String month = DateTime(2023, i).month.toString();

      double budgetAmount = 5000.00 + (random.nextInt(500) - 250);
      // add a random amount between -250 and 250 to the budget amount

      List<Transaction> transactions = [];

      for (int j = 1; j <= 5; j++) {
        int numTransactions = 1 + random.nextInt(3);
        // add between 1 and 3 transactions per day

        for (int k = 1; k <= numTransactions; k++) {
          double transactionAmount = 50.00 + random.nextInt(450);
          // add a random amount between 50 and 500 to the transaction amount

          DateTime transactionDate = DateTime(2023, i, j);
          // set the transaction date to the current day

          Transaction transaction = Transaction(
            category: categories[random.nextInt(categories.length)],
            name: transactionNames[random.nextInt(transactionNames.length)],
            amount: transactionAmount,
            date: transactionDate,
          );

          transactions.add(transaction);
        }
      }

      Budget budget = Budget(
        name: "Budget $month",
        amount: budgetAmount,
        transactions: transactions,
        month: month,
      );

      budgets.add(budget);
    }
  }

  List<Budget> get budgets => _budgets;

  void addTransaction(Budget budget, Transaction transaction) {
    budget.transactions.add(
        transaction); // Add the transaction to the budget's list of transactions
  }

  void removeTransaction(Budget budget, Transaction transaction) {
    budget.transactions.remove(
        transaction); // Remove the transaction from the budget's list of transactions
  }

  void addBudget(Budget budget) {
    _budgets.add(budget);
    notifyListeners();
  }

  void removeBudget(Budget budget) {
    _budgets.remove(budget);
    notifyListeners();
  }

  void updateBudget(Budget budget) {
    notifyListeners();
  }

  Map<String, double> getCategoricalExpense(List<Transaction> transactions) {
    Map<String, double> categoricalExpense =
        {}; // Initialize an empty map to store the categorical expenses

    // Loop through each transaction in the list
    for (Transaction transaction in transactions) {
      String category =
          transaction.category; // Get the category of the transaction
      double amount = transaction.amount; // Get the amount of the transaction

      // If the category already exists in the map, add the transaction amount to the existing value
      if (categoricalExpense.containsKey(category)) {
        categoricalExpense[category] = categoricalExpense[category]! + amount;
      }
      // If the category does not yet exist in the map, create a new key-value pair
      else {
        categoricalExpense[category] = amount;
      }
    }

    return categoricalExpense; // Return the map of categorical expenses
  }

  double getTotalExpenseForMonth(List<Transaction> transactions, String month) {
    double totalExpense = 0; // Initialize a variable to store the total expense

    // Loop through each transaction in the list
    for (Transaction transaction in transactions) {
      int transactionMonth =
          transaction.date.month; // Get the month of the transaction
      double amount = transaction.amount; // Get the amount of the transaction

      // If the transaction occurred in the specified month, add its amount to the total expense
      if (transactionMonth == month) {
        totalExpense += amount;
      }
    }

    return totalExpense; // Return the total expense for the specified month
  }

//   Map<String, double> getSpendingByDayOfWeek(List<Transaction> transactions) {
//   Map<String, double> spendingByDayOfWeek = {
//     'Monday': 0,
//     'Tuesday': 0,
//     'Wednesday': 0,
//     'Thursday': 0,
//     'Friday': 0,
//     'Saturday': 0,
//     'Sunday': 0,
//   };

//   transactions.forEach((transaction) {
//     // Get the day of the week from the transaction date
//     String dayOfWeek = DateFormat('EEEE').format(transaction.date);

//     // Add the transaction amount to the corresponding day of the week in the map
//     spendingByDayOfWeek[dayOfWeek] += transaction.amount;
//   });

//   return spendingByDayOfWeek;
// }
}
