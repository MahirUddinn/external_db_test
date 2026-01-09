import 'package:external_db_test/domain/entities/item.dart';
import 'package:external_db_test/domain/repositories/item_repository.dart';

class UpdateItem {
  final ItemRepository repository;

  UpdateItem(this.repository);

  Future<Item> call(Item item) async {
    return await repository.updateItem(item);
  }
}
