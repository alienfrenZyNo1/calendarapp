// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stpeters_calendar_app/bloc/calendar/calendar_bloc.dart';
import 'package:stpeters_calendar_app/data/repositories/calendar_repository.dart';

import 'ui/calendar_screen.dart';
// Import other feature screens/widgets here

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CalendarBloc(MockCalendarRepository()),
          ),
          // Add other BlocProviders for different features here
        ],
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Return the initial screen of your application
    return const CalendarScreen();
    // Return other initial screens for different features if needed
  }
}
