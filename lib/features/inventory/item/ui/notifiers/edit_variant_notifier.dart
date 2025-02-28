import '../../../../../core/common/enums/common_enums.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/common/notifiers/save_status_provider.dart';
import '../../../unit/domain/entities/unit.dart';
import '../../domain/entities/item.dart';

class EditVariantProvider extends ChangeNotifier{
  Key _key = UniqueKey();

  late SaveStatusNotifier saveStatusNotifier;

  final Variant _editingVariant;
  late final String _variantId;
  late final String _itemId;

  late final String _itemName;
  String get itemName => _itemName;
  set itemName(String name) {
    _itemName = name;
    notifyListeners();
    saveStatusNotifier.setSaveStatus(_key, SaveStatus.canSave);
  }

  
  late String _variantName;
  String get variantName => _variantName;
  set variantName(String name) {
    _variantName = name;
    notifyListeners(); saveStatusNotifier.setSaveStatus(_key, SaveStatus.canSave);
  }

  late String? _barcode;
  String? get barcode => _barcode;
  set barcode(String? barcode) {
    _barcode = barcode;
    notifyListeners(); saveStatusNotifier.setSaveStatus(_key, SaveStatus.canSave);
  }

  late String? _sku;
  String? get sku => _sku;
  set sku(String? sku) {
    _sku = sku;
    notifyListeners(); saveStatusNotifier.setSaveStatus(_key, SaveStatus.canSave);
  }

  late double _price;
  double get price => _price;
  set price(double price) {
    _price = price;
    notifyListeners(); saveStatusNotifier.setSaveStatus(_key, SaveStatus.canSave);
  }
  
  late double? _productionCost;
  double? get productionCost => _productionCost;
  set productionCost(double? cost) {
    _productionCost = cost;
    notifyListeners(); saveStatusNotifier.setSaveStatus(_key, SaveStatus.canSave);
  }

  late Unit _unit = Unit.pcs();
  Unit get unit => _unit;
  set unit(Unit unit) {
    _unit = unit;
    notifyListeners(); saveStatusNotifier.setSaveStatus(_key, SaveStatus.canSave);
  }

  late double? _stockCount;
  double? get stockCount => _stockCount;
  set stockCount(double? count) {
    _stockCount = count;
    notifyListeners(); saveStatusNotifier.setSaveStatus(_key, SaveStatus.canSave);
  }

  late double? _stockAlertAt;
  double? get stockAlertAt => _stockAlertAt;
  set stockAlertAt(double? alertAt) {
    _stockAlertAt = alertAt;
    notifyListeners(); saveStatusNotifier.setSaveStatus(_key, SaveStatus.canSave);
  }



  EditVariantProvider(this._editingVariant,){
    saveStatusNotifier = SaveStatusNotifier(_key);
    _variantId = _editingVariant.id;
    _itemName = _editingVariant.itemName;
    _itemId = _editingVariant.itemId;
    _variantName = _editingVariant.variantName;
    _barcode = _editingVariant.barcode;
    _sku = _editingVariant.sku;
    _price = _editingVariant.price;
    _productionCost = _editingVariant.productionCost;
    _unit = _editingVariant.unitDetails;
    _stockCount = _editingVariant.stockCount;
    _stockAlertAt = _editingVariant.stockAlertAt;
  }


  // _checkIfCanSave() {
  //   if(_variantName != _editingVariant.variantName || _price != _editingVariant.price || _sku != _editingVariant.sku
  //     || _barcode != _editingVariant.barcode || 
  //   ) {

  //     if(saveStatusNotifier.saveStatus != SaveStatus.canSave) saveStatusNotifier.setSaveStatus(_key, SaveStatus.canSave);

  //   } else {

  //     if(saveStatusNotifier.saveStatus != SaveStatus.canNotSave) saveStatusNotifier.setSaveStatus(_key, SaveStatus.canNotSave);
  //   }
  // }


  Variant modifiedVariant() {
    if(saveStatusNotifier.saveStatus == SaveStatus.canSave) {
      return _editingVariant.copyWith(
        variantName: _variantName,
        barcode: _barcode,
        sku: _sku,
        price: _price,
        productionCost: _productionCost,
        unitDetails: _unit,
        stockCount: _stockCount,
        stockAlertAt: _stockAlertAt,
      );
    } else {
      return _editingVariant;
    }
  }
}