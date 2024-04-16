// ui/widgets/calendar_drawer.dart

import 'package:flutter/material.dart';
import 'package:stpeters_calendar_app/models/calendar_view.dart';
import '../../utils/logger.dart';

class CalendarDrawer extends StatelessWidget {
  final VoidCallback onMonthViewTap;
  final VoidCallback onWeekViewTap;
  final VoidCallback onDayViewTap;

  const CalendarDrawer({
    super.key,
    required this.onMonthViewTap,
    required this.onWeekViewTap,
    required this.onDayViewTap,
    required CalendarView currentView,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Month View'),
            onTap: () {
              logger.d('Month View tapped');
              onMonthViewTap();
            },
          ),
          ListTile(
            title: const Text('Week View'),
            onTap: () {
              logger.d('Week View tapped');
              onWeekViewTap();
            },
          ),
          ListTile(
            title: const Text('Day View'),
            onTap: () {
              logger.d('Day View tapped');
              onDayViewTap();
            },
          ),
        ],
      ),
    );
  }
}
