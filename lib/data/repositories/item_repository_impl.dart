import 'package:external_db_test/data/datasources/item_remote_data_source.dart';
import 'package:external_db_test/data/models/item_model.dart';
import 'package:external_db_test/domain/entities/item.dart';
import 'package:external_db_test/domain/repositories/item_repository.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ItemRemoteDataSource remoteDataSource;

  ItemRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Item>> getItems() async {
    try {
      final itemModels = await remoteDataSource.getItems();
      return itemModels;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Item> addItem(Item item) async {
    try {
      final itemModel = ItemModel(
        id: item.id,
        itemCode: item.itemCode,
        itemBarcode: item.itemBarcode,
        itemName: item.itemName,
        itemNameBn: item.itemNameBn,
        itemDes: item.itemDes,
        itemStock: item.itemStock,
        itemSalesPrice: item.itemSalesPrice,
        itemGeneralDiscount: item.itemGeneralDiscount,
        itemPurPrice: item.itemPurPrice,
      );
      return await remoteDataSource.addItem(itemModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Item> updateItem(Item item) async {
    try {
      final itemModel = ItemModel(
        id: item.id,
        itemCode: item.itemCode,
        itemBarcode: item.itemBarcode,
        itemName: item.itemName,
        itemNameBn: item.itemNameBn,
        itemDes: item.itemDes,
        itemStock: item.itemStock,
        itemSalesPrice: item.itemSalesPrice,
        itemGeneralDiscount: item.itemGeneralDiscount,
        itemPurPrice: item.itemPurPrice,
      );
      return await remoteDataSource.updateItem(itemModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteItem(int id) async {
    try {
      await remoteDataSource.deleteItem(id);
    } catch (e) {
      throw Exception(e);
    }
  }
}
