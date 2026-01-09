import 'package:external_db_test/domain/entities/item.dart';

abstract class ItemRepository {
  Future<List<Item>> getItems();
  Future<Item> addItem(Item item);
  Future<Item> updateItem(Item item);
  Future<void> deleteItem(int id);
}
