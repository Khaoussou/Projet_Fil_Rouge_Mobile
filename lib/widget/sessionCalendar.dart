import 'package:flutter/material.dart';
import 'package:gestion_school_odc/model/session.dart';
import 'package:gestion_school_odc/register/api.dart';
import 'package:table_calendar/table_calendar.dart';

import '../model/user.dart';
import 'drawer.dart';

class SessionCalendar extends StatefulWidget {
  final User user;
  final int courId;

  const SessionCalendar({super.key, required this.user, required this.courId});

  @override
  State<SessionCalendar> createState() => _SessionCalendarState();
}

class _SessionCalendarState extends State<SessionCalendar> {

  DateTime today = DateTime.now();
  SessionResponse? sessionResponse;

  @override
  void initState() {
    super.initState();
    print(today);
    _getSessions();
  }
  _getSessions() {
    Api().getUserSession("courSessionUsers", widget.user.id, widget.courId).then((response) {
      setState(() {
        sessionResponse = response;
      });
    });
    print(sessionResponse);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenue'),
      ),
      drawer: DrawerWidget(user: widget.user),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.grey[300]),
            padding: const EdgeInsets.all(10),
            child: TableCalendar(
              rowHeight: 43,
              headerStyle: const HeaderStyle(
                  formatButtonVisible: false, titleCentered: true),
              focusedDay: today,
              firstDay: DateTime.utc(2000, 11, 20),
              lastDay: DateTime.utc(2030, 11, 20),
            ),
          )
        ],
      ),
    );
  }
}
