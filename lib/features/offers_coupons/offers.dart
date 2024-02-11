import 'package:budget_buddy/components/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class OfferScreen extends StatefulWidget {
  static const id = '/offers';
  const OfferScreen({super.key});

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Your Offers',
      ),
      body: Column(children: [

      ]),
    );
  }
}

class OfferTile extends StatelessWidget {
  const OfferTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}