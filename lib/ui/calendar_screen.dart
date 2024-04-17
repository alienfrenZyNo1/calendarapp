// ui/calendar_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/calendar/calendar_bloc.dart';
import '../models/calendar_view.dart';
import 'widgets/calendar_drawer.dart';
import 'widgets/calendar_widget.dart'; // Import the ScheduleView widget
import '../utils/logger.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({
    super.key,
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
              child: _buildBody(context, currentView), // Call _buildBody method
            ),
            drawer: CalendarDrawer(
              currentView: currentView, // Pass the current view to the drawer
              onMonthViewTap: () {
                _switchToView(context, CalendarView.month);
              },
              onWeekViewTap: () {
                _switchToView(context, CalendarView.week);
              },
              onDayViewTap: () {
                _switchToView(context, CalendarView.day);
              },
              onScheduleViewTap: () {
                // Handle tapping on Schedule View
                logger.d('Navigating to Schedule view...');
                BlocProvider.of<CalendarBloc>(context)
                    .add(NavigateToScheduleView());
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

  // Method to build the body based on the current view
  Widget _buildBody(BuildContext context, CalendarView currentView) {
    return CalendarWidget(
      currentView: currentView,
      onCurrentViewChange: (view) {
        // Implement the logic to handle the change in current view
        // You can dispatch an event to update the calendar view in the bloc
        logger.d('Current view changed to: $view');
      },
    );
  }
}

// Method to switch to a different calendar view
void _switchToView(BuildContext context, CalendarView view) {
  logger.d('Switching to $view view...');
  BlocProvider.of<CalendarBloc>(context).add(ChangeView(view));
  Navigator.of(context).pop(); // Close the drawer after switching view
}
