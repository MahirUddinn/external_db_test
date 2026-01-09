import 'package:external_db_test/domain/entities/item.dart';
import 'package:external_db_test/domain/usecases/add_item.dart';
import 'package:external_db_test/domain/usecases/delete_item.dart';
import 'package:external_db_test/domain/usecases/get_items.dart';
import 'package:external_db_test/domain/usecases/update_item.dart';
import 'package:external_db_test/presentation/cubit/item_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemCubit extends Cubit<ItemState> {
  final GetItems getItems;
  final AddItem addItem;
  final UpdateItem updateItem;
  final DeleteItem deleteItem;

  ItemCubit({
    required this.getItems,
    required this.addItem,
    required this.updateItem,
    required this.deleteItem,
  }) : super(const ItemState());

  Future<void> fetchItems() async {
    emit(state.copyWith(status: ItemStatus.loading));
    try {
      final items = await getItems();
      emit(state.copyWith(status: ItemStatus.success, items: items));
    } catch (e) {
      emit(
        state.copyWith(status: ItemStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> createItem(Item item) async {
    emit(state.copyWith(status: ItemStatus.loading));
    try {
      await addItem(item);
      final items = await getItems();
      emit(state.copyWith(status: ItemStatus.success, items: items));
    } catch (e) {
      emit(
        state.copyWith(status: ItemStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> editItem(Item item) async {
    emit(state.copyWith(status: ItemStatus.loading));
    try {
      await updateItem(item);
      final items = await getItems();
      emit(state.copyWith(status: ItemStatus.success, items: items));
    } catch (e) {
      emit(
        state.copyWith(status: ItemStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> removeItem(int id) async {
    emit(state.copyWith(status: ItemStatus.loading));
    try {
      await deleteItem(id);
      final items = await getItems();
      emit(state.copyWith(status: ItemStatus.success, items: items));
    } catch (e) {
      emit(
        state.copyWith(status: ItemStatus.failure, errorMessage: e.toString()),
      );
    }
  }
}
