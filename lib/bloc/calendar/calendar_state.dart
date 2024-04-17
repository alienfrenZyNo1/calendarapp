// bloc/calendar/calendar_state.dart
part of 'calendar_bloc.dart';
// Import CalendarView

@immutable
abstract class CalendarState extends Equatable {
  const CalendarState();

  @override
  List<Object> get props => [];
}

class InitialState extends CalendarState {}

class LoadedState extends CalendarState {
  final List<CalendarEventModel> events;
  final CalendarView view; // Added view parameter

  const LoadedState(this.events, {required this.view});

  @override
  List<Object> get props => [events, view];
}

class ErrorState extends CalendarState {
  final String message;

  const ErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class CalendarViewState extends CalendarState {
  final CalendarView view;

  const CalendarViewState(this.view);

  @override
  List<Object> get props => [view];
}
