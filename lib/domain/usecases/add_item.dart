import 'package:external_db_test/domain/entities/item.dart';
import 'package:external_db_test/domain/repositories/item_repository.dart';

class AddItem {
  final ItemRepository repository;

  AddItem(this.repository);

  Future<Item> call(Item item) async {
    return await repository.addItem(item);
  }
}
