// data/repositories/calendar_repository.dart
import 'package:faker/faker.dart';
import 'package:stpeters_calendar_app/models/calendar_event_model.dart';

import '../../utils/logger.dart';

class MockCalendarRepository implements CalendarRepository {
  // final List<CalendarEventModel> _events = [
  //   CalendarEventModel(
  //     id: "event_1",
  //     title: "Staff Meeting",
  //     description: "Monthly staff meeting to discuss school progress",
  //     startDate: DateTime(2024, 04, 25, 10, 0), // Adjust date/time as needed
  //     endDate: DateTime(2024, 04, 25, 11, 0), // Adjust date/time as needed
  //   ),
  //   CalendarEventModel(
  //     id: "event_2",
  //     title: "Science Fair",
  //     description: "Annual science fair showcasing student projects",
  //     startDate: DateTime(2024, 05, 10, 14, 0), // Adjust date/time as needed
  //     endDate: DateTime(2024, 05, 10, 17, 0), // Adjust date/time as needed
  //   ),
  //   CalendarEventModel(
  //     id: "event_3",
  //     title: "Marty Party",
  //     description: "Annual marty party",
  //     startDate: DateTime(2024, 05, 10, 14, 0), // Adjust date/time as needed
  //     endDate: DateTime(2024, 05, 10, 17, 0), // Adjust date/time as needed
  //   ),
  // ];

  final List<CalendarEventModel> _events = List.generate(1000, (index) {
    final faker = Faker();
    final randomStartDays = faker.randomGenerator
        .integer(15); // Generate random number of days within 15 days
    final randomEndHours = faker.randomGenerator
        .integer(24); // Generate random number of hours within 24 hours
    final startDate = DateTime.now().add(Duration(days: randomStartDays));
    final endDate = startDate.add(Duration(hours: randomEndHours));
    return CalendarEventModel(
      id: "event_${index + 1}",
      title: faker.company.name(),
      description: faker.lorem.sentence(),
      startDate: startDate,
      endDate: endDate,
    );
  });

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
