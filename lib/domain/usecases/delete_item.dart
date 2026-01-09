import 'package:external_db_test/domain/repositories/item_repository.dart';

class DeleteItem {
  final ItemRepository repository;

  DeleteItem(this.repository);

  Future<void> call(int id) async {
    return await repository.deleteItem(id);
  }
}
