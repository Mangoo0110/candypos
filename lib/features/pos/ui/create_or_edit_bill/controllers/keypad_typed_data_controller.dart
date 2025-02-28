
// import 'dart:collection';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import '../../../../inventory/item&variant/domain/entities/variant.dart';
// import '../../../domain/entities/sale_item.dart';

// class KeypadBillingController extends ChangeNotifier {

//   List<Variant> _itemVariantListOfStore = [];

//   SaleItem? _saleItem ;

//   bool _userChoosed = false;
  
//   String _priceXquantity = '';

//   final List<String> _keypadNumChars = ['.','0','1','2','3','4','5','6','7','8','9',];

//   bool _tappedMultiply = false;

//   final String _multiplyString = ' X ';

//   SaleItem? get saleItem => _saleItem;

//   String get priceXquantity => _priceXquantity;

//   bool get tappedMultiply => _tappedMultiply;

//   bool get userChoosed => _userChoosed;

//   KeypadBillingController(){
//     _newRef();
//   }

//   void update({required SplayTreeMap<String, VariantModel> idMappedVariantOfStore}) {
//     _itemVariantListOfStore = idMappedVariantOfStore.entries.map((e) => e.value).toList();
//     notifyListeners();
//   }
  

//   void _newRef() {
//     _saleItem = SaleItem.fromKeypadTypedDetails(itemName: 'Custom', itemId: 'custom', price: 0, quantity: 1);
//     _tappedMultiply = false;
//     _userChoosed = false;
//     _priceXquantity = '';
//     notifyListeners();
//   }

//   addKeypadTextAndParse(String keypadText) {
//     keypadText = _trimKeypadText(keypadText);

//     String quantityString = '', priceString = '';
//     String tempPriceXquantity = "$_priceXquantity$keypadText";
//     final splittedString = tempPriceXquantity.split(_multiplyString);

//     if(splittedString.isNotEmpty) {
//       priceString = splittedString[0];
//     } 
//     if(splittedString.length > 1) {
//       quantityString = splittedString[1];
//     } 
//     if(double.tryParse(priceString) != null) {
//       saleItem!.changePrice(price: double.parse(priceString));

//       if(double.tryParse(quantityString) != null) {
//         saleItem!.setQuantity(quantity: double.parse(quantityString));
//         _priceXquantity += keypadText;
//       }
//       if(quantityString.isEmpty) {
//         _priceXquantity += keypadText;
//       }
//     }
//     // if(keypadText.contains('.')) {
//     //   if(_tappedMultiply) {

//     //   }
//     // }
    
//     notifyListeners();
//   }

//   String _trimKeypadText(String keypadText) {
//     String trimmedText = '';
//     for(final char in keypadText.characters) {
//       if(_keypadNumChars.contains(char)) trimmedText += char;
//     }
//     return trimmedText;
//   }


//   multiplyTapped() {
//     if(_tappedMultiply) return;
//     _tappedMultiply = true;
//     _priceXquantity += _multiplyString;
//     notifyListeners();
//   }


//   void clearItemSale() {
//     _priceXquantity = '';
//     _tappedMultiply = false;
//     _userChoosed = false;
//     _newRef();
//     notifyListeners();
//   }

//   replaceCustomItemWithChoosenItem(SaleItem chossenBilledItem) {
//     dekhao("chossenBilledItem ${chossenBilledItem.toMap()}");
//     chossenBilledItem.changePrice(price: _saleItem!.price);
//     chossenBilledItem.setQuantity(quantity: _saleItem!.quantity);
    
//     _saleItem = chossenBilledItem;
//     _userChoosed = true;
//     notifyListeners();
//   }

//   removeChoosenItem() {
//     double price = 0;
//     double quantity = 1;
//     if(saleItem != null) {
//       price = saleItem!.price;
//       quantity = saleItem!.quantity;
//     }
//     _newRef();
//     if(saleItem != null) {
//       saleItem!.changePrice(price: price);
//       saleItem!.setQuantity(quantity: quantity);
//     }
//     _userChoosed = false;
//     notifyListeners();
//   }


//   List<SaleItem> suggestItemVariantByPrice() {
//     dekhao("suggestItemVariantByPrice");
//     double typedPrice = saleItem!.price;
//     List<SaleItem> withPriceSuggestions = [];
//     List<SaleItem> withoutPriceSuggestions = [];

//     for(final variant in _itemVariantListOfStore) {
//       if(double.tryParse(variant.price) != null && double.parse(variant.price) == typedPrice) {
//         withPriceSuggestions.add(SaleItem.fromVariant(itemVariant: variant));
//       } 
//       if(variant.price.trim().isEmpty) {
//         withoutPriceSuggestions.add(SaleItem.fromVariant(itemVariant: variant));
//       }
//     }
//     //notifyListeners();
//     if(withPriceSuggestions.isEmpty) {
//       return withoutPriceSuggestions;
//     }
//     return withPriceSuggestions;
    
//   }

// }