import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/product_repository.dart';
import 'profile_screen_model.dart';
import 'profile_screen_wm.dart';


// Я делал изначально на ноуте = Всё запускалось, когда решил доделать на компе - вечные ошибки с библеотеками и тд.
// Материал на сколько мог я разобрал + еще доп. информацию почитал. Но допилить чтоб с компа у меня всё ок было - к сожелению не вышло(
// Но надеюсь что все ок будет, ибо я старался)  

class ProfileScreen extends ElementaryWidget<IProfileWidgetModel> {
  const ProfileScreen({
    Key? key,
    required WidgetModelFactory wmFactory,
  }) : super(wmFactory, key: key);

  factory ProfileScreen.defaultFactory({Key? key}) {
    return ProfileScreen(
      key: key,
      wmFactory: _defaultWmFactory,
    );
  }

  @override
  Widget build(IProfileWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder<EntityState>(
          valueListenable: wm.userState,
          builder: (context, state, _) {
            if (state is ContentState<User?>) {
              final user = state.data;
              if (user != null) {
                return Text('${user.name} (${user.email})');
              }
            }
            return const Text('Загрузка...');
          },
        ),
      ),
      body: ValueListenableBuilder<EntityState>(
        valueListenable: wm.productState,
        builder: (context, state, _) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ErrorState) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Ошибка'),
                  ElevatedButton(
                    onPressed: wm.loadData,
                    child: const Text('Повторить'),
                  ),
                ],
              ),
            );
          }

          if (state is ContentState<List<String>>) {
            final data = state.data;
            if (data != null) {
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: data.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(data[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => wm.deleteItem(index),
                      ),
                    ),
                  );
                },
              );
            }
          }

          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: wm.createNewProduct,
        child: const Icon(Icons.add),
      ),
    );
  }
}

WidgetModelFactory get _defaultWmFactory => 
  (context) => ProfileWidgetModel(ProfileModel(ProductRepository()));