import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'components/mock_data.dart';

class Transactions extends StatefulWidget {
  static const String id = '/transactions';
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  final CalendarController _calendarController = CalendarController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
        onTap: (calendarTapDetails) {
          print(calendarTapDetails.targetElement);
          print(calendarTapDetails.targetElement.index);
          //open bottom modal sheet

          // showModalBottomSheet(
          //     context: context,
          //     builder: (context) {
          //       return Container(
          //         height: 1000,
          //         color: Colors.white,
          //         child: Center(
          //           child: Text('Hello'),
          //         ),
          //       );
          //     });
        },
        // allowAppointmentResize: true,
        allowDragAndDrop: true,
        // allowViewNavigation: true,
        todayTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 6,
          fontWeight: FontWeight.bold,
        ),
        allowedViews: [
          CalendarView.week,
          CalendarView.month,
        ],
        view: CalendarView.month,
        dataSource: MeetingDataSource(_getDataSource()),
        monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
      ),
    );
  }
}

List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));
  meetings.addAll([
    Meeting('Conference', startTime, endTime, const Color(0xFF0F8644), false),
    Meeting('Team meeting', DateTime(2023, 4, 10, 9, 0),
        DateTime(2023, 4, 10, 10, 0), const Color(0xFF0F8644), false),
    Meeting('Client call', DateTime(2023, 4, 11, 14, 0),
        DateTime(2023, 4, 11, 15, 0), const Color(0xFFE91E63), true),
    Meeting('Product demo', DateTime(2023, 4, 12, 11, 0),
        DateTime(2023, 4, 12, 12, 0), const Color(0xFF2196F3), false),
    Meeting('Marketing brainstorm', DateTime(2023, 4, 13, 15, 0),
        DateTime(2023, 4, 13, 16, 30), const Color(0xFFF44336), true),
    Meeting('Project status update', DateTime(2023, 4, 14, 10, 0),
        DateTime(2023, 4, 14, 11, 0), const Color(0xFFFFC107), false),
    Meeting('Team building activity', DateTime(2023, 4, 17, 14, 0),
        DateTime(2023, 4, 17, 16, 0), const Color(0xFF4CAF50), false),
    Meeting('Budget review', DateTime(2023, 4, 18, 11, 0),
        DateTime(2023, 4, 18, 12, 0), const Color(0xFF607D8B), true),
    Meeting('Client meeting', DateTime(2023, 4, 19, 9, 0),
        DateTime(2023, 4, 19, 10, 30), const Color(0xFF9C27B0), false),
    Meeting('Technical training', DateTime(2023, 4, 20, 13, 0),
        DateTime(2023, 4, 20, 15, 0), const Color(0xFF795548), false),
    Meeting('Business development', DateTime(2023, 4, 21, 16, 0),
        DateTime(2023, 4, 21, 17, 0), const Color(0xFFCDDC39), true),
    Meeting('Team meeting', DateTime(2023, 4, 10, 9, 0),
        DateTime(2023, 4, 10, 10, 0), const Color(0xFF0F8644), false),
    Meeting('Client call', DateTime(2023, 4, 11, 14, 0),
        DateTime(2023, 4, 11, 15, 0), const Color(0xFFE91E63), true),
    Meeting('Product demo', DateTime(2023, 4, 12, 11, 0),
        DateTime(2023, 4, 12, 12, 0), const Color(0xFF2196F3), false),
    Meeting('Marketing brainstorm', DateTime(2023, 4, 13, 15, 0),
        DateTime(2023, 4, 13, 16, 30), const Color(0xFFF44336), true),
    Meeting('Project status update', DateTime(2023, 4, 14, 10, 0),
        DateTime(2023, 4, 14, 11, 0), const Color(0xFFFFC107), false),
    Meeting('Team building activity', DateTime(2023, 4, 17, 14, 0),
        DateTime(2023, 4, 17, 16, 0), const Color(0xFF4CAF50), false),
    Meeting('Budget review', DateTime(2023, 4, 18, 11, 0),
        DateTime(2023, 4, 18, 12, 0), const Color(0xFF607D8B), true),
    Meeting('Client meeting', DateTime(2023, 4, 19, 9, 0),
        DateTime(2023, 4, 19, 10, 30), const Color(0xFF9C27B0), false),
    Meeting('Technical training', DateTime(2023, 4, 20, 13, 0),
        DateTime(2023, 4, 20, 15, 0), const Color(0xFF795548), false),
    Meeting('Business development', DateTime(2023, 4, 21, 16, 0),
        DateTime(2023, 4, 21, 17, 0), const Color(0xFFCDDC39), true),
  ]);

  final Random random = Random();

  for (int i = 0; i < 40; i++) {
    final int hour = random.nextInt(12) + 9; // Random hour between 9am to 8pm
    final int minute = random.nextInt(60); // Random minute
    final DateTime startDate =
        DateTime(2023, 4, random.nextInt(30) + 1, hour, minute);
    final DateTime endDate = startDate.add(Duration(
        hours: random.nextInt(3) + 1)); // Random duration between 1 to 3 hours
    final Color color = Color.fromRGBO(random.nextInt(256), random.nextInt(256),
        random.nextInt(256), 1); // Random color
    final bool isAllDay = random.nextBool(); // Random all-day event
    final Meeting meeting =
        Meeting('Meeting ${i + 1}', startDate, endDate, color, isAllDay);
    meetings.add(meeting);
  }

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
