import 'dart:async';
import 'package:bloc/bloc.dart';
import 'app_events.dart';
import 'app_states.dart';

class AppBloc extends Bloc<AppEvents, AppStates> {
  AppBloc() : super(AppInitialState()) {
    on<AppLoadDataEvent>(_loadData);
    on<AppReloadDataEvent>(_reloadData);
    on<AppDeleteDataItemEvent>(_deleteDataItem);
  }

  List<String> data = [];

  Future<void> _loadData(AppLoadDataEvent event, Emitter<AppStates> emit) async {
    emit(AppLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    data = ['1', '2', '3'];
    emit(AppLoadedState(data: data));
  }

  Future<void> _reloadData(AppReloadDataEvent event, Emitter<AppStates> emit) async {
    emit(AppDeleteLoadingState(data: data));
    await Future.delayed(const Duration(seconds: 3));
    data = ['1', '2', '3'];
    emit(AppLoadedState(data: data));
  }

  Future<void> _deleteDataItem(AppDeleteDataItemEvent event, Emitter<AppStates> emit) async {
    emit(AppDeleteLoadingState(data: data));
    await Future.delayed(const Duration(seconds: 3));
    data.removeAt(event.itemIndex);
    emit(AppLoadedState(data: data));
  }
}