import 'package:external_db_test/data/datasources/item_remote_data_source.dart';
import 'package:external_db_test/data/repositories/item_repository_impl.dart';
import 'package:external_db_test/domain/usecases/add_item.dart';
import 'package:external_db_test/domain/usecases/delete_item.dart';
import 'package:external_db_test/domain/usecases/get_items.dart';
import 'package:external_db_test/domain/usecases/update_item.dart';
import 'package:external_db_test/presentation/cubit/item_cubit.dart';
import 'package:http/http.dart' as http;

class ServiceLocator {
  static final http.Client _client = http.Client();

  static ItemCubit getItemCubit() {
    final remoteDataSource = ItemRemoteDataSourceImpl(client: _client);
    final repository = ItemRepositoryImpl(remoteDataSource: remoteDataSource);

    return ItemCubit(
      getItems: GetItems(repository),
      addItem: AddItem(repository),
      updateItem: UpdateItem(repository),
      deleteItem: DeleteItem(repository),
    );
  }
}
