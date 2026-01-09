import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final int? id;
  final String itemCode;
  final String? itemBarcode;
  final String itemName;
  final String? itemNameBn;
  final String? itemDes;
  final num itemStock;
  final num itemSalesPrice;
  final num? itemGeneralDiscount;
  final num? itemPurPrice;

  const Item({
    this.id,
    required this.itemCode,
    this.itemBarcode,
    required this.itemName,
    this.itemNameBn,
    this.itemDes,
    required this.itemStock,
    required this.itemSalesPrice,
    this.itemGeneralDiscount,
    this.itemPurPrice,
  });

  @override
  List<Object?> get props => [
    id,
    itemCode,
    itemBarcode,
    itemName,
    itemNameBn,
    itemDes,
    itemStock,
    itemSalesPrice,
    itemGeneralDiscount,
    itemPurPrice,
  ];
}
