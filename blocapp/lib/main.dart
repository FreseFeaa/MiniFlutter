import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/app_bloc.dart';
import 'bloc/app_events.dart';
import 'bloc/navigation_bloc.dart';
import 'bloc/navigation_states.dart';
import 'screens/home_screen.dart';
import 'screens/other_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppBloc()..add(AppLoadDataEvent())),
        BlocProvider(create: (context) => NavigationBloc()),
      ],
      child: MaterialApp(
        title: 'Bloc Navigation Demo',
        routes: {
          '/': (context) => const HomeScreen(),
          '/other': (context) => const OtherScreen(),
        },
        builder: (context, child) {
          return BlocListener<NavigationBloc, NavigationState>(
            listener: (context, state) {
              if (state is NavigationTriggerState) {
                Navigator.pushNamed(context, state.routeName);
              }
            },
            child: child,
          );
        },
      ),
    );
  }
}