// import 'dart:collection';
// import 'dart:isolate';
// import 'dart:typed_data';

// import '../../core/utils/func/dekhao.dart';
// import '../../features/pos/ui/providers/cart_item.dart';
// import '../../features/inventory/item/domain/entities/item.dart';
// import '../../features/pos/ui/providers/pos_objects.dart';
// import 'pos_ui_providers.dart';
// import 'inventory_data_provider.dart';

// class InventoryDataToPosData extends PosDataSkeleton{

//   InventoryDataToPosData._(){
//     _listenToInventoryDataChanges();
//   }
  
//   static InventoryDataToPosData? _instance;
//   static InventoryDataToPosData get instance {
//     _instance ??= InventoryDataToPosData._();
//     return _instance!;
//   }


//   _listenToInventoryDataChanges() {
//     // Listen to inventory data changes
//     while(InventoryDataProvider.instance.itemSubscription == null) {
      
//     }

//     InventoryDataProvider.instance.itemSubscription!.onData((items) async{
//         // Update the item lines
//         // Isolate worker to convert items to item lines
//         isUpdating = true;
//         await Worker().convertItemsToItemLines(items)
//         .then((convertedItemLines) {
//           itemLines.addAll(convertedItemLines);
//           isUpdating = false;
//           notifyListeners();
//         });

        
//       });
    
//     // Listen to item image changes
//     InventoryDataProvider.instance.itemImageData.addListener(() {

//       itemImages.addAll(InventoryDataProvider.instance.itemImageData.images);
//       notifyListeners();
//     });
    
    
//   }

// }


// class Worker{

//   Future<SplayTreeMap<String, ItemLine>> convertItemsToItemLines(List<Item> items, ) async {
//     final receivePort = ReceivePort();

//     await Isolate.spawn(
//         _convertItems, 
//         [
//           receivePort.sendPort, 
//           items, 
//           InventoryDataProvider.instance.itemImageData.images
//         ]
//     );
//     return await receivePort.first;
//   }

//   static void _convertItems(List<dynamic> args) {
//     final sendPort = args[0] as SendPort;
//     final items = args[1] as List<Item>;
//     final SplayTreeMap<String, Uint8List> itemImages = args[2] as SplayTreeMap<String, Uint8List>;

//     SplayTreeMap<String, ItemLine> itemLines = SplayTreeMap();
    
//     for(final item in items) {
//       final itemLine = item.toItemLine(itemImages[item.id]);
//       itemLines.addAll({item.id: itemLine});
//       dekhao("Item line added: ${itemLine.itemName}");
//     }

//     sendPort.send(itemLines);
//   }
// }


// extension ToItemLine on Item {
//   ItemLine toItemLine(Uint8List? itemImage) {
    
//     final Map<String, LineVariant> lineVariants = {};
//     lineVariants.addEntries({MapEntry(baseVariant.id, baseVariant.toLineVariant())});
//     lineVariants.addAll(variants.map((key, value) => MapEntry(key, (value.toLineVariant()))));
  
//     return ItemLine(
//       itemId: id,
//       itemName: itemName,
//       categories: categoryIdMapName,
//       primaryPrice: baseVariant.price,
//       posIndex: index,
//       image: itemImage,
//       uploadMeta: uploadDetails, 
//       variants: lineVariants,
//     );
//   }
// }



// extension ToLineVariant on Variant{

//   LineVariant toLineVariant() {
//     return LineVariant(
//       variantId: id,
//       itemName: variantName,
//       price: price,
//       itemId: itemId,
//       sku: sku,
//       itemBarcode: barcode,
//       variantName: variantName,
//       unitDetails: unitDetails,
//     );
//   }
// }