import 'Budget.dart';
import 'User.dart';

class Group {
  String name;
  List<User> members;
  List<GroupBudget> budgets;

  Group({required this.name, required this.members, required this.budgets});

  List<GroupTransaction> get allTransactions {
    List<GroupTransaction> transactions = [];

    for (GroupBudget budget in budgets) {
      transactions.addAll(budget.transactions);
    }

    return transactions;
  }
}

class GroupTransaction {
  String name;
  double amount;
  DateTime date;
  String category;
  User paidBy;

  GroupTransaction({
    required this.name,
    required this.amount,
    required this.date,
    required this.category,
    required this.paidBy,
  });
}

class GroupBudget {
  String name;
  double amount;
  List<GroupTransaction> transactions;

  GroupBudget(
      {required this.name, required this.amount, required this.transactions});

  double get remainingAmount {
    double totalSpent = 0;

    for (GroupTransaction transaction in transactions) {
      totalSpent += transaction.amount;
    }

    return amount - totalSpent;
  }
}
