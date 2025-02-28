
import '../../features/inventory/item/domain/entities/item.dart';
import '../../features/pos/domain/entities/addon.dart';
import '../../features/pos/domain/entities/sale_item.dart';

extension ToSaleItem on Variant {
  SaleItem toSaleItem({required List<AddOn> addOns, String note = "", required double quantity}) {
    return SaleItem(
      itemId: itemId,
      variantId: id,
      sku: sku,
      itemBarcode: barcode,
      itemName: itemName,
      variantName: variantName,
      price: price,
      saleDiscount: null,
      unitDetails: unitDetails,
      quantity: quantity,
      addOns: addOns,
      note: note,
    );
  }
}