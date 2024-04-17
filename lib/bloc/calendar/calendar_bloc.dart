// bloc/calendar/calendar_bloc.dart

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/calendar_repository.dart';
import '../../models/calendar_event_model.dart';
import '../../models/calendar_view.dart';
import '../../utils/logger.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final CalendarRepository calendarRepository;

  CalendarBloc(this.calendarRepository)
      : super(const CalendarViewState(CalendarView.month)) {
    on<LoadEvents>(_handleLoadEvents);
    on<AddEvent>(_handleAddEvent);
    on<DeleteEvent>(_handleDeleteEvent);
    on<ChangeView>(_handleChangeView);
    on<NavigateToScheduleView>(_handleNavigateToScheduleView);
  }

  Future<void> _handleLoadEvents(
      LoadEvents event, Emitter<CalendarState> emit) async {
    try {
      logger.d('Fetching events from repository...');
      final events = await calendarRepository.getEvents();
      final view = state is CalendarViewState
          ? (state as CalendarViewState).view
          : CalendarView.month;
      emit(LoadedState(events, view: view));
    } catch (e) {
      _handleError(e, emit);
    }
  }

  Future<void> _handleAddEvent(
      AddEvent event, Emitter<CalendarState> emit) async {
    try {
      logger.d('Adding event: ${event.event}');
      await calendarRepository.addEvent(event.event);
      await _handleLoadEvents(LoadEvents(), emit);
    } catch (e) {
      _handleError(e, emit);
    }
  }

  Future<void> _handleDeleteEvent(
      DeleteEvent event, Emitter<CalendarState> emit) async {
    try {
      logger.d('Deleting event with ID: ${event.eventId}');
      await calendarRepository.deleteEvent(event.eventId);
      await _handleLoadEvents(LoadEvents(), emit);
    } catch (e) {
      _handleError(e, emit);
    }
  }

  void _handleChangeView(ChangeView event, Emitter<CalendarState> emit) {
    logger.d('Changing calendar view to: ${event.view}');
    emit(CalendarViewState(event.view));
  }

  void _handleNavigateToScheduleView(
      NavigateToScheduleView event, Emitter<CalendarState> emit) {
    logger.d('Navigating to Schedule View');
    emit(const CalendarViewState(
        CalendarView.schedule)); // Emit CalendarViewState with Schedule view
  }

  void _handleError(dynamic error, Emitter<CalendarState> emit) {
    logger.e('Error: $error');
    emit(ErrorState(error.toString()));
  }
}
