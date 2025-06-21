abstract class NavigationState {}

class NavigationInitialState extends NavigationState {}

class NavigationTriggerState extends NavigationState {
  final String routeName;
  NavigationTriggerState(this.routeName);
}