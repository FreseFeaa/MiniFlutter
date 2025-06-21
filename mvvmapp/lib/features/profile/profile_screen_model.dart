import 'package:elementary/elementary.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/product_repository.dart';

abstract class IProfileModel extends ElementaryModel {
  Future<List<String>> getProducts();
  Future<User> getUser();
  Future<String> createProduct();
}

class ProfileModel extends IProfileModel {
  final ProductRepository _repository;

  ProfileModel(this._repository);

  @override
  Future<List<String>> getProducts() => _repository.getProducts();

  @override
  Future<User> getUser() => _repository.getUser();

  @override
  Future<String> createProduct() => _repository.createProduct();
}