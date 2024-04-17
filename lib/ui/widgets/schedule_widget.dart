// ui/widgets/schedule_widget.dart

import 'package:flutter/material.dart';

class ScheduleWidget extends StatelessWidget {
  const ScheduleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock list of events for testing
    List<Event> events = [
      Event(
          title: 'Meeting',
          startTime: const TimeOfDay(hour: 9, minute: 0),
          endTime: const TimeOfDay(hour: 10, minute: 0)),
      Event(
          title: 'Lunch',
          startTime: const TimeOfDay(hour: 12, minute: 0),
          endTime: const TimeOfDay(hour: 13, minute: 0)),
      Event(
          title: 'Presentation',
          startTime: const TimeOfDay(hour: 14, minute: 0),
          endTime: const TimeOfDay(hour: 15, minute: 0)),
      Event(
          title: 'Training',
          startTime: const TimeOfDay(hour: 16, minute: 0),
          endTime: const TimeOfDay(hour: 17, minute: 0)),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Open drawer
            Scaffold.of(context).openDrawer();
          },
        ),
        title: const Text('Schedule'),
      ),
      drawer: Drawer(
        // Add your existing drawer implementation here
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update UI based on drawer item selection
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update UI based on drawer item selection
              },
            ),
            // Add more ListTile widgets as needed
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return ListTile(
            title: Text(event.title),
            subtitle: Text(
                '${event.startTime.format(context)} - ${event.endTime.format(context)}'),
            onTap: () {
              // Add functionality to handle tapping on events
            },
          );
        },
      ),
    );
  }
}

class Event {
  final String title;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  Event({required this.title, required this.startTime, required this.endTime});
}
