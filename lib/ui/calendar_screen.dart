// ui/calendar_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/calendar/calendar_bloc.dart';
import '../models/calendar_view.dart';
import 'widgets/calendar_drawer.dart';
import 'widgets/calendar_widget.dart';
import '../utils/logger.dart'; // Import logger

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({
    super.key, // Add Key parameter to match the super constructor
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        logger.d('CalendarScreen state: $state'); // Log the current state
        if (state is CalendarViewState || state is LoadedState) {
          // If the state is CalendarViewState or LoadedState, build the calendar
          final currentView = state is CalendarViewState
              ? state.view
              : (state as LoadedState).view; // Handle both state types
          logger.d('currentView: $currentView'); // Log the current state
          return Scaffold(
            body: SafeArea(
              child: CalendarWidget(
                currentView: currentView,
                onCurrentViewChange: (view) {
                  // Implement the logic to handle the change in current view
                  // You can dispatch an event to update the calendar view in the bloc
                  logger.d('Current view changed to: $view');
                },
              ),
            ),
            drawer: CalendarDrawer(
              currentView: currentView, // Pass the current view to the drawer
              onMonthViewTap: () {
                logger.d('Switching to Month view...');
                BlocProvider.of<CalendarBloc>(context)
                    .add(const ChangeView(CalendarView.month));
                Navigator.of(context)
                    .pop(); // Close the drawer after switching view
              },
              onWeekViewTap: () {
                logger.d('Switching to Week view...');
                BlocProvider.of<CalendarBloc>(context)
                    .add(const ChangeView(CalendarView.week));
                Navigator.of(context)
                    .pop(); // Close the drawer after switching view
              },
              onDayViewTap: () {
                logger.d('Switching to Day view...');
                BlocProvider.of<CalendarBloc>(context)
                    .add(const ChangeView(CalendarView.day));
                Navigator.of(context)
                    .pop(); // Close the drawer after switching view
              },
            ),
          );
        } else {
          // If the state is not CalendarViewState or LoadedState, show the loading indicator
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
