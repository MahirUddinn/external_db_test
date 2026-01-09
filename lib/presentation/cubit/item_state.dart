import 'package:equatable/equatable.dart';
import 'package:external_db_test/domain/entities/item.dart';

enum ItemStatus { initial, loading, success, failure }

class ItemState extends Equatable {
  final ItemStatus status;
  final List<Item> items;
  final String? errorMessage;

  const ItemState({
    this.status = ItemStatus.initial,
    this.items = const <Item>[],
    this.errorMessage,
  });

  ItemState copyWith({
    ItemStatus? status,
    List<Item>? items,
    String? errorMessage,
  }) {
    return ItemState(
      status: status ?? this.status,
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, items, errorMessage];
}
