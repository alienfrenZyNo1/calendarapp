// bloc/calendar/calendar_event.dart
part of 'calendar_bloc.dart';

@immutable
abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

class LoadEvents extends CalendarEvent {}

class AddEvent extends CalendarEvent {
  final CalendarEventModel event;

  const AddEvent(this.event);

  @override
  List<Object> get props => [event];
}

class DeleteEvent extends CalendarEvent {
  final String eventId;

  const DeleteEvent(this.eventId);

  @override
  List<Object> get props => [eventId];
}

// Define a new event to handle calendar view changes
class ChangeView extends CalendarEvent {
  final CalendarView view;

  const ChangeView(this.view);

  @override
  List<Object> get props => [view];
}

// Add more events like UpdateEvent etc. if needed

class NavigateToScheduleView extends CalendarEvent {}
