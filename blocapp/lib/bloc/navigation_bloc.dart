import 'package:bloc/bloc.dart';
import 'navigation_events.dart';
import 'navigation_states.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitialState()) {
    on<NavigateToOtherScreenEvent>((event, emit) {
      emit(NavigationTriggerState('/other'));
      emit(NavigationInitialState());
    });
  }
}