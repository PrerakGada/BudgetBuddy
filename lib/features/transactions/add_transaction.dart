import 'package:flutter/material.dart';

import '../../themes/palette.dart';
import '../../widgets/labeledTextFormField.dart';
import '../BucketList/create_bucket_list.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  late bool isIncome = false;
  late bool isExpense = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Add Transaction',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            LabeledTextFormField(
              controller: _dateController,
              title: 'Date',
              hintTitle: 'Enter the Event\'s Title',
              icon: Icons.calendar_month_outlined,
              function: () async {
                DateTime selectedDate = DateTime.now();
                final DateTimeRange? picked = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(1901, 1),
                  lastDate: DateTime(2100),
                );
                if (picked != null && picked != selectedDate)
                  _dateController.text =
                      "${picked.start.year}-${picked.start.month}-${picked.start.day} to ${picked.start.year}-${picked.start.month}-${picked.start.day}";
              },
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Amount',
              ),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select category",
                  style: TextStyle(
                    fontSize: 16,
                    color: Palette.white,
                  ),
                ),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () {
                    showModalBottomSheet<void>(
                      // context and builder are
                      // required properties in this widget
                      context: context,
                      builder: (BuildContext context) {
                        // we set up a container inside which
                        // we create center column and display text

                        // Returning SizedBox instead of a Container
                        return SizedBox(
                          height: 300,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: GridView.builder(
                                  itemCount: 20,
                                  physics: const BouncingScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    childAspectRatio: 2,
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return CategoryItem(
                                      index: index,
                                      length: 20,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).primaryColorDark.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Personal",
                            style: TextStyle(
                              fontSize: 16,
                              color: Palette.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text('Transaction Type:    '),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      isIncome = !isIncome;
                    });
                  },
                  child: Text(
                    'Income',
                    style: TextStyle(
                        color: isIncome ? Colors.green : Colors.white),
                  ),
                  style: ButtonStyle(),
                ),
                SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      isIncome = !isIncome;
                    });
                  },
                  child: Text(
                    'Expense',
                    style:
                        TextStyle(color: isIncome ? Colors.white : Colors.red),
                  ),
                  style: ButtonStyle(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Note',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
