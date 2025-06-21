import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/app_bloc.dart';
import '../bloc/app_events.dart';
import '../bloc/app_states.dart'; // Важно!
import '../bloc/navigation_bloc.dart'; // Важно!
import '../bloc/navigation_events.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppBloc, AppStates>(
        builder: (context, state) {
          if (state is AppLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AppLoadedState) {
            return Stack(
              children: [
                ListView.builder(
                  itemCount: state.data.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => context.read<AppBloc>().add(
                      AppDeleteDataItemEvent(itemIndex: index),
                    ),
                    child: Center(
                      child: Text(state.data[index]),
                    ),
                  ),
                ),
                if (state is AppDeleteLoadingState)
                  const Center(child: CircularProgressIndicator()),
              ],
            );
          }
          return const Center(child: Text('Нажмите для загрузки данных'));
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => context.read<AppBloc>().add(AppReloadDataEvent()),
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => context.read<NavigationBloc>().add(
              NavigateToOtherScreenEvent(),
            ),
            child: const Icon(Icons.navigate_next),
          ),
        ],
      ),
    );
  }
}