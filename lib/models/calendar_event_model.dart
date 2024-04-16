// models/calendar_event_model.dart
class CalendarEventModel {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;

  CalendarEventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
  });
}
