// data/repositories/calendar_repository.dart
import 'package:stpeters_calendar_app/models/calendar_event_model.dart';

import '../../utils/logger.dart';

class MockCalendarRepository implements CalendarRepository {
  final List<CalendarEventModel> _events = [
    CalendarEventModel(
      id: "event_1",
      title: "Staff Meeting",
      description: "Monthly staff meeting to discuss school progress",
      startDate: DateTime(2024, 04, 25, 10, 0), // Adjust date/time as needed
      endDate: DateTime(2024, 04, 25, 11, 0), // Adjust date/time as needed
    ),
    CalendarEventModel(
      id: "event_2",
      title: "Science Fair",
      description: "Annual science fair showcasing student projects",
      startDate: DateTime(2024, 05, 10, 14, 0), // Adjust date/time as needed
      endDate: DateTime(2024, 05, 10, 17, 0), // Adjust date/time as needed
    ),
  ];

  @override
  Future<List<CalendarEventModel>> getEvents() async {
    // Log a message indicating that events are being fetched
    logger.d("Fetching events from mock repository...");

    // Return the mock data synchronously
    return Future.value(_events);
  }

  @override
  Future<void> addEvent(CalendarEventModel event) async {
    // Implement logic to add event to your chosen data source (e.g., Firestore)
    // For now, just log a message indicating that the event is being added
    logger.d("Event added: $event");
  }

  @override
  Future<void> deleteEvent(String eventId) async {
    // Implement logic to delete event from your chosen data source (e.g., Firestore)
    // For now, just log a message indicating that the event is being deleted
    logger.d("Event deleted with ID: $eventId");
  }
}

abstract class CalendarRepository {
  Future<List<CalendarEventModel>> getEvents();
  Future<void> addEvent(CalendarEventModel event);
  Future<void> deleteEvent(String eventId);
}
