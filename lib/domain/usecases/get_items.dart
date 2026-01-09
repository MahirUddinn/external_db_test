import 'package:external_db_test/domain/entities/item.dart';
import 'package:external_db_test/domain/repositories/item_repository.dart';

class GetItems {
  final ItemRepository repository;

  GetItems(this.repository);

  Future<List<Item>> call() async {
    return await repository.getItems();
  }
}
