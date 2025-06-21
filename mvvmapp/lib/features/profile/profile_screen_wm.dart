import 'dart:async';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'profile_screen_model.dart';

abstract class IProfileWidgetModel implements IWidgetModel {
  ValueNotifier<EntityState> get productState;
  ValueNotifier<EntityState> get userState;
  
  void deleteItem(int index);
  void createNewProduct();
  Future<void> loadData();
}

class ProfileWidgetModel extends WidgetModel implements IProfileWidgetModel {
  final ProfileModel _model;
  
  final _productState = EntityStateNotifier();
  final _userState = EntityStateNotifier();
  final List<StreamSubscription> _subscriptions = [];

  ProfileWidgetModel(this._model) : super(_model);

  @override
  ValueNotifier<EntityState> get productState => _productState;

  @override
  ValueNotifier<EntityState> get userState => _userState;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    loadData();
  }

  @override
  Future<void> loadData() async {
    _productState.loading();
    _userState.loading();
    
    try {
      final products = await _model.getProducts();
      final user = await _model.getUser();
      
      _productState.content(products);
      _userState.content(user);
    } catch (e) {
      _productState.error(e as Exception);
      _userState.error(e as Exception);
    }
  }

  @override
  void deleteItem(int index) {
    final data = _productState.value.data as List<String>?;
    if (data == null || index < 0 || index >= data.length) return;
    
    final newData = List<String>.from(data)..removeAt(index);
    _productState.content(newData);
  }

  @override
  void createNewProduct() async {
    try {
      final newProduct = await _model.createProduct();
      final currentData = _productState.value.data as List<String>? ?? [];
      _productState.content([...currentData, newProduct]);
    } catch (e) {
      _productState.error(e as Exception);
    }
  }

  @override
  void dispose() {
    for (var sub in _subscriptions) {
      sub.cancel();
    }
    super.dispose();
  }
}