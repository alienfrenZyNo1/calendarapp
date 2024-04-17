import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; // Import DateFormat
import '../../bloc/calendar/calendar_bloc.dart';
import '../../models/calendar_event_model.dart'; // Import CalendarEventModel

class ScheduleWidget extends StatelessWidget {
  const ScheduleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        if (state is LoadedState) {
          // Check if events are loaded successfully
          final events = state.events;
          // Group events by date
          final groupedEvents = _groupEventsByDate(events);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              title: const Text('Schedule'),
            ),
            body: ListView.builder(
              itemCount: groupedEvents.length,
              itemBuilder: (context, index) {
                final date = groupedEvents.keys.toList()[index];
                final dateEvents = groupedEvents[date]!;
                return _buildDateSection(date, dateEvents);
              },
            ),
          );
        } else {
          // If events are not loaded yet, show a loading indicator
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // Helper function to group events by date
  Map<DateTime, List<CalendarEventModel>> _groupEventsByDate(
      List<CalendarEventModel> events) {
    final groupedEvents = <DateTime, List<CalendarEventModel>>{};
    for (final event in events) {
      final date = DateTime(
          event.startDate.year, event.startDate.month, event.startDate.day);
      if (!groupedEvents.containsKey(date)) {
        groupedEvents[date] = [];
      }
      groupedEvents[date]!.add(event);
    }
    return groupedEvents;
  }

  // Helper function to build a section for a specific date
  Widget _buildDateSection(DateTime date, List<CalendarEventModel> events) {
    final formattedDate = DateFormat.yMMMMd().format(date);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Text(
            formattedDate,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            final startTimeFormatted = DateFormat.Hm().format(event.startDate);
            final endTimeFormatted = DateFormat.Hm().format(event.endDate);
            return ListTile(
              title: Text(event.title),
              subtitle: Text('$startTimeFormatted - $endTimeFormatted'),
              onTap: () {
                // Add functionality to handle tapping on events
              },
            );
          },
        ),
        const Divider(),
      ],
    );
  }
}
