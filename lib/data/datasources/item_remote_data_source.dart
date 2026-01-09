import 'dart:convert';
import 'package:external_db_test/core/api_constants.dart';
import 'package:external_db_test/data/models/item_model.dart';
import 'package:http/http.dart' as http;

abstract class ItemRemoteDataSource {
  Future<List<ItemModel>> getItems();
  Future<ItemModel> addItem(ItemModel item);
  Future<ItemModel> updateItem(ItemModel item);
  Future<void> deleteItem(int id);
}

class ItemRemoteDataSourceImpl implements ItemRemoteDataSource {
  final http.Client client;

  ItemRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ItemModel>> getItems() async {
    final response = await client.get(Uri.parse(ApiConstants.itemsEndpoint));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => ItemModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  @override
  Future<ItemModel> addItem(ItemModel item) async {
    final response = await client.post(
      Uri.parse(ApiConstants.itemsEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(item.toJson()),
    );

    if (response.statusCode == 201) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add item');
    }
  }

  @override
  Future<ItemModel> updateItem(ItemModel item) async {
    final response = await client.put(
      Uri.parse('${ApiConstants.itemsEndpoint}/${item.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(item.toJson()),
    );

    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update item');
    }
  }

  @override
  Future<void> deleteItem(int id) async {
    final response = await client.delete(
      Uri.parse('${ApiConstants.itemsEndpoint}/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete item');
    }
  }
}
