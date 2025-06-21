abstract class AppEvents {}

class AppLoadDataEvent extends AppEvents {}

class AppReloadDataEvent extends AppEvents {}

class AppDeleteDataItemEvent extends AppEvents {
  AppDeleteDataItemEvent({
    required this.itemIndex,
  });
  final int itemIndex;
}