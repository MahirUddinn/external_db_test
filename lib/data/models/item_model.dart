import 'package:external_db_test/domain/entities/item.dart';

class ItemModel extends Item {
  const ItemModel({
    super.id,
    required super.itemCode,
    super.itemBarcode,
    required super.itemName,
    super.itemNameBn,
    super.itemDes,
    required super.itemStock,
    required super.itemSalesPrice,
    super.itemGeneralDiscount,
    super.itemPurPrice,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['item_id'] is String
          ? int.tryParse(json['item_id'])
          : json['item_id'],
      itemCode: json['item_code'],
      itemBarcode: json['item_barcode'],
      itemName: json['item_name'],
      itemNameBn: json['item_name_bn'],
      itemDes: json['item_des'],
      itemStock: json['item_stock'] is String
          ? num.tryParse(json['item_stock']) ?? 0
          : json['item_stock'],
      itemSalesPrice: json['item_sales_price'] is String
          ? num.tryParse(json['item_sales_price']) ?? 0
          : json['item_sales_price'],
      itemGeneralDiscount: json['item_general_discount'] is String
          ? num.tryParse(json['item_general_discount'])
          : json['item_general_discount'],
      itemPurPrice: json['item_pur_price'] is String
          ? num.tryParse(json['item_pur_price'])
          : json['item_pur_price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item_id': id,
      'item_code': itemCode,
      'item_barcode': itemBarcode,
      'item_name': itemName,
      'item_name_bn': itemNameBn,
      'item_des': itemDes,
      'item_stock': itemStock,
      'item_sales_price': itemSalesPrice,
      'item_general_discount': itemGeneralDiscount,
      'item_pur_price': itemPurPrice,
    };
  }
}
