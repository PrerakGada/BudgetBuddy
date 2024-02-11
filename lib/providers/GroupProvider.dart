import 'package:flutter/material.dart';

class Expense {
  final String username;
  final String title;
  final String description;
  final double amount;

  Expense({
    required this.username,
    required this.title,
    required this.description,
    required this.amount,
  });
}

class Group {
  final String name;
  final List<String> members;
  final double budget;
  final List<Expense> expenses;

  Group({
    required this.name,
    required this.members,
    required this.budget,
    required this.expenses,
  });
}

class GroupProvider extends ChangeNotifier {
  final List<Group> _groups = [
    Group(
      name: 'Goa Trip',
      members: ['Anjali Gupta', 'Vikram Joshi', 'Aman Verma', 'Rohini Singh'],
      budget: 50000,
      expenses: [
        Expense(
          username: 'Anjali Gupta',
          title: 'Hotel Booking',
          description:
              'Booked a 4-star hotel with a swimming pool in North Goa.',
          amount: 15000,
        ),
        Expense(
          username: 'Vikram Joshi',
          title: 'Flight Tickets',
          description: 'Booked round-trip flights from New Delhi to Goa.',
          amount: 20000,
        ),
        Expense(
          username: 'Aman Verma',
          title: 'Food & Drinks',
          description:
              'Tried various restaurants and beach shacks serving Goan cuisine and drinks.',
          amount: 8000,
        ),
        Expense(
          username: 'Rohini Singh',
          title: 'Shopping',
          description:
              'Bought souvenirs like Goan spices, cashews, and beachwear from local markets and shops.',
          amount: 7000,
        ),
        Expense(
          username: 'Anjali Gupta',
          title: 'Sightseeing',
          description:
              'Visited popular tourist attractions like Fort Aguada, Anjuna Beach, and Chapora Fort.',
          amount: 5000,
        ),
      ],
    ),
    Group(
      name: 'Beach Party',
      members: ['Kunal Sharma', 'Riya Singh', 'Arjun Gupta', 'Priya Mehta'],
      budget: 20000,
      expenses: [
        Expense(
          username: 'Kunal Sharma',
          title: 'Renting the Beach House',
          description:
              'Booked a beach house with 3 bedrooms and a private pool for the weekend party.',
          amount: 8000,
        ),
        Expense(
          username: 'Anjali Gupta',
          title: 'Grocery Shopping',
          description:
              'Bought snacks, drinks, and party supplies like balloons, streamers, and props.',
          amount: 5000,
        ),
        Expense(
          username: 'Arjun Gupta',
          title: 'BBQ Grill and Meat',
          description:
              'Bought a portable BBQ grill and various meats like chicken, lamb, and seafood.',
          amount: 4000,
        ),
        Expense(
          username: 'Priya Mehta',
          title: 'Decorations',
          description:
              'Decorated the beach house with fairy lights, candles, and flower arrangements.',
          amount: 3000,
        ),
        Expense(
          username: 'Riya Singh',
          title: 'Transportation',
          description:
              'Booked a mini-bus for the group to travel from the city to the beach house.',
          amount: 2000,
        ),
      ],
    ),
    Group(
      name: 'Team Lunch',
      members: ['Amit Patel', 'Neha Shah', 'Sanjay Desai', 'Meera Gupta'],
      budget: 5000,
      expenses: [
        Expense(
          username: 'Anjali Gupta',
          title: 'Ordering Food',
          description:
              'Ordered a variety of dishes like pizzas, sandwiches, salads, and desserts.',
          amount: 3000,
        ),
        Expense(
          username: 'Neha Shah',
          title: 'Beverages',
          description: 'Bought soft drinks, juices, and mineral water bottles.',
          amount: 1000,
        ),
        Expense(
          username: 'Sanjay Desai',
          title: 'Office Space Rental',
          description: 'Booked a conference room for the team lunch.',
          amount: 1000,
        ),
        Expense(
          username: 'Meera Gupta',
          title: 'Utensils and Cutlery',
          description: 'Brought disposable plates, cups, spoons, and forks.',
          amount: 500,
        ),
      ],
    ),
    Group(
        name: 'Movie Night',
        members: [
          'Sagar Verma',
          'Manisha Singh',
          'Vishal Sharma',
          'Priyanka Patel'
        ],
        budget: 3000,
        expenses: [
          Expense(
            username: 'Sagar Verma',
            title: 'Movie Tickets',
            description:
                'Booked tickets for a latest movie release at a nearby theater.',
            amount: 1200,
          ),
          Expense(
            username: 'Anjali Gupta',
            title: 'Snacks and Beverages',
            description:
                'Bought popcorn, nachos, candies, and soft drinks for everyone.',
            amount: 800,
          ),
          Expense(
            username: 'Vishal Sharma',
            title: 'Transportation',
            description:
                'Hired a cab to pick up and drop off the group members.',
            amount: 500,
          ),
          Expense(
            username: 'Priyanka Patel',
            title: 'Home Theatre Rental',
            description:
                'Rented a home theatre system with a large screen and high-quality sound.',
            amount: 500,
          )
        ]),
        Group(
  name: 'Christmas Party',
  members: ['John Doe', 'Jane Smith', 'Mark Johnson', 'Emily Brown'],
  budget: 5000,
  expenses: [
    Expense(
      username: 'John Doe',
      title: 'Venue Rental',
      description: 'Rented a banquet hall for the Christmas party.',
      amount: 2000,
    ),
    Expense(
      username: 'Jane Smith',
      title: 'Decorations',
      description: 'Bought decorations like lights, Christmas tree, and ornaments.',
      amount: 800,
    ),
    Expense(
      username: 'Anjali Gupta',
      title: 'Food and Drinks',
      description: 'Ordered food and drinks like turkey, ham, wine, and beer.',
      amount: 1500,
    ),
    Expense(
      username: 'Emily Brown',
      title: 'Gifts',
      description: 'Bought gifts for all the members of the group.',
      amount: 700,
    ),
  ],
)
  ];

  List<Group> get groups => _groups;

  void addGroup(Group group) {
    _groups.add(group);
    notifyListeners();
  }

  void removeGroup(Group group) {
    _groups.remove(group);
    notifyListeners();
  }
}
