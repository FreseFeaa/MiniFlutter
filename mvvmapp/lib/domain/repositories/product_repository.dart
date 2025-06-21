import '../models/user.dart'; // Исправленный импорт

class ProductRepository {
  Future<List<String>> getProducts() async {
    await Future.delayed(const Duration(seconds: 3));
    return ['Продукт 1', 'Продукт 2', 'Продукт 3'];
  }

  Future<User> getUser() async {
    await Future.delayed(const Duration(seconds: 2));
    return User(name: 'Иван Иванов', email: 'ivan@example.com');
  }

  Future<String> createProduct() async {
    await Future.delayed(const Duration(seconds: 1));
    return 'Новый продукт ${DateTime.now().second}';
  }
}