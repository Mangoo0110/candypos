// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import '../../../inventory/unit/data/models/unit_model.dart';
import '../../../inventory/unit/domain/entities/unit.dart';
import 'item_add_on.dart';

class CartItem with ChangeNotifier {
  final String itemId;

  final String variantId;

  final String? sku;

  final String? itemBarcode;

  final String itemName;

  final String variantName;

  final Unit unitDetails;

  final double _price;
  double get price => _price;

  double _discount;
  double get discount => _discount;
  set discount(double discount) {
    _discount = discount;
    _doTotal();
  }

  double _quantity;
  double get quantity => _quantity;
  set quantity(double quantity){
    _quantity = quantity;
    _doTotal();
  }

  double _totalPrice;
  double get totalPrice => _totalPrice;

  List<ItemAddOn> _addedAddOns;
  List<ItemAddOn> get addedAddOns => List.from(_addedAddOns);

  String note;

  CartItem({
    required this.itemId,
    required this.variantId,
    required this.sku,
    required this.itemBarcode,
    required this.itemName,
    required this.variantName,
    required double price,
    required double discount,
    required this.unitDetails,
    required double quantity,
    required double totalPrice,
    required List<ItemAddOn> addedAddOns,
    required this.note,
  }) : _price = price, 
  _quantity = quantity, 
  _totalPrice = totalPrice,
  _discount = discount,
  _addedAddOns = addedAddOns;

  CartItem copyWith({
    String? itemId,
    String? variantId,
    String? sku,
    String? itemBarcode,
    String? itemName,
    String? variantName,
    double? price,
    double? discountPrice,
    UnitModel? unitDetails,
    double? quantity,
    double? totalPrice,
    List<ItemAddOn>? addedAddOns,
    String? note,
  }) {
    return CartItem(
      itemId: itemId ?? this.itemId,
      variantId: variantId ?? this.variantId,
      sku: sku ?? this.sku,
      itemBarcode: itemBarcode ?? this.itemBarcode,
      itemName: itemName ?? this.itemName,
      variantName: variantName ?? this.variantName,
      price: price ?? _price,
      discount: discountPrice ?? _discount,
      unitDetails: unitDetails ?? this.unitDetails,
      quantity: quantity ?? _quantity,
      totalPrice: totalPrice ?? _totalPrice,
      addedAddOns: addedAddOns ?? _addedAddOns,
      note: note ?? this.note,
    );
  }


  _doTotal() {
    double addOnsTotalPrice = 0;

    for(final addOn in _addedAddOns) {
      addOnsTotalPrice += addOn.price * addOn.quantity;
    }
    _totalPrice = addOnsTotalPrice + (_price - _discount) * _quantity; notifyListeners();
  }

  addAddOn(ItemAddOn addOn) {
    _addedAddOns.add(addOn); notifyListeners();
    _doTotal();
  }


  @override
  String toString() {
    return 'CartItem(itemId: $itemId, variantId: $variantId, sku: $sku, itemBarcode: $itemBarcode, itemName: $itemName, variantName: $variantName, price: $_price, discountPrice: $_discount, unitDetails: $unitDetails, quantity: $_quantity, totalPrice: $_totalPrice, billedModifierList: $_addedAddOns, note: $note)';
  }


  @override
  bool operator ==(covariant CartItem other) {
    if (identical(this, other)) return true;
  
    return 
      other.itemId == itemId &&
      other.variantId == variantId &&
      other.sku == sku &&
      other.itemBarcode == itemBarcode &&
      other.itemName == itemName &&
      other.variantName == variantName &&
      other._price == _price &&
      other._discount == _discount &&
      other.unitDetails == unitDetails &&
      other._quantity == _quantity &&
      other._totalPrice == _totalPrice &&
      listEquals(other._addedAddOns, _addedAddOns) &&
      other.note == note;
  }

  @override
  int get hashCode {
    return itemId.hashCode ^
      variantId.hashCode ^
      sku.hashCode ^
      itemBarcode.hashCode ^
      itemName.hashCode ^
      variantName.hashCode ^
      _price.hashCode ^
      _discount.hashCode ^
      unitDetails.hashCode ^
      _quantity.hashCode ^
      _totalPrice.hashCode ^
      _addedAddOns.hashCode ^
      note.hashCode;
  }
}
