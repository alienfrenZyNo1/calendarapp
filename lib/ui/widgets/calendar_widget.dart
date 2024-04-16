// ui/widgets/calendar_widget.dart
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/calendar/calendar_bloc.dart';
import '../../models/calendar_event_model.dart';
import '../../models/calendar_view.dart';
import '../../utils/logger.dart'; // Import logger

class CalendarWidget extends StatefulWidget {
  final CalendarView currentView;
  final void Function(CalendarView)?
      onCurrentViewChange; // Define the callback function

  const CalendarWidget({
    super.key,
    required this.currentView,
    required this.onCurrentViewChange,
  });

  @override
  CalendarWidgetState createState() => CalendarWidgetState();

  // Define the method to handle the change in current view
  void updateCurrentView(CalendarView view) {
    if (onCurrentViewChange != null) {
      onCurrentViewChange!(view);
    }
  }
}

class CalendarWidgetState extends State<CalendarWidget> {
  late EventController _eventController;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _eventController = EventController();
    _selectedDay = DateTime.now();
  }

  @override
  void didUpdateWidget(CalendarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update _currentView when receiving a new prop
    if (oldWidget.currentView != widget.currentView) {
      setState(() {
        _selectedDay = DateTime.now();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        if (state is LoadedState) {
          final events = state.events;
          _updateEvents(events);
          return _buildCalendar();
        } else {
          // Handle other states such as loading or error
          logger.d('Loading events...');
          logger.d('Current state: $state');
          BlocProvider.of<CalendarBloc>(context).add(LoadEvents());
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void _updateEvents(List<CalendarEventModel> events) {
    final eventData = _mapEventsToEventData(events).toList();
    _eventController.addAll(eventData); // Add all events to the controller
  }

  Iterable<CalendarEventData<Object?>> _mapEventsToEventData(
      List<CalendarEventModel> events) {
    return events.map((event) => CalendarEventData(
          date: event.startDate, // Using start time as the date
          title: event.title,
        ));
  }

  Widget _buildCalendar() {
    return Column(
      children: [
        _buildCalendarControls(),
        Expanded(
          child: _buildCalendarView(),
        ),
      ],
    );
  }

  Widget _buildCalendarControls() {
    return Row(
      children: [
        DropdownButton<CalendarView>(
          value: widget.currentView,
          onChanged: (view) {
            logger.d('Dropdown onChanged: Setting current view to $view');
            // Notify parent widget about the change in view if the callback function is not null
            widget.onCurrentViewChange
                ?.call(view!); // Add null check with ?.call
          },
          items: const [
            DropdownMenuItem(
              value: CalendarView.month,
              child: Text('Month'),
            ),
            DropdownMenuItem(
              value: CalendarView.week,
              child: Text('Week'),
            ),
            DropdownMenuItem(
              value: CalendarView.day,
              child: Text('Day'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCalendarView() {
    final headerStyle = _buildHeaderStyle();

    switch (widget.currentView) {
      case CalendarView.month:
        return MonthView(
          key: UniqueKey(),
          controller: _eventController,
          initialMonth: DateTime(_selectedDay.year, _selectedDay.month, 1),
          onDateLongPress: (date) =>
              logger.d('Month View: Long pressed on $date'),
          headerStringBuilder: (date, {DateTime? secondaryDate}) {
            final monthName = DateFormat.yMMMM().format(date);
            return monthName;
          },
          headerStyle: headerStyle,
        );
      case CalendarView.week:
        return WeekView(
          key: UniqueKey(),
          controller: _eventController,
          initialDay: _selectedDay,
          onEventTap: (events, date) => logger.d('Week View: Tapped on $date'),
          onDateLongPress: (date) =>
              logger.d('Week View: Long pressed on $date'),
          headerStyle: headerStyle,
        );
      case CalendarView.day:
        return DayView(
          key: UniqueKey(),
          controller: _eventController,
          initialDay: _selectedDay,
          onEventTap: (events, date) => logger.d('Day View: Tapped on $date'),
          onDateLongPress: (date) =>
              logger.d('Day View: Long pressed on $date'),
          headerStyle: headerStyle,
        );
      case CalendarView.workWeek:
        return Container(); // Placeholder for now
      default:
        return Container();
    }
  }

  HeaderStyle _buildHeaderStyle() {
    return HeaderStyle(
      decoration: const BoxDecoration(
        color: Colors.blue, // Set the background color
      ),
      leftIcon: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: _onDrawerOpen,
      ),
      rightIconVisible: false,
      titleAlign: TextAlign.left,
    );
  }

  void _onDrawerOpen() {
    // Implement the logic to open the drawer here
    logger.d('Drawer opened');
    Scaffold.of(context).openDrawer();
  }
}
