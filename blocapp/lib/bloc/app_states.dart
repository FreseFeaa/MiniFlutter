abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppLoadingState extends AppStates {}

class AppLoadedState extends AppStates {
  AppLoadedState({
    required this.data,
  });
  final List<String> data;
}

class AppDeleteLoadingState extends AppLoadedState {
  AppDeleteLoadingState({required super.data});
}