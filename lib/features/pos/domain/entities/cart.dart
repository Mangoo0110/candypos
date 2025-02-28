
import '../../../../core/common/domains/upload_meta.dart';
import '../../../../core/common/enums/common_enums.dart';
import 'delivery_info.dart';
import 'sale_customer.dart';
import 'sale_discount.dart';
import 'sale_item.dart';
import 'sale_tax.dart';

class Cart {

  final String id;
  final ServiceType serviceType;
  final List<String> servicedByIds;
  final CustomerInfo? customerInfo;
  final List<SaleItem> saleItemList;
  final double subTotal;
  final SaleDiscount? saleDiscount;
  final Map<int, SaleTax> idMappedTax;
  final double grandTotal;
  final DeliveryInfo? deliveryInfo;
  final UploadMeta? uploadMetaDetails;

  Cart({
    required this.id,
    required this.serviceType,
    required this.servicedByIds,
    required this.customerInfo,
    required this.saleItemList,
    required this.subTotal,
    this.saleDiscount,
    required this.idMappedTax,
    required this.grandTotal,
    this.deliveryInfo,
    this.uploadMetaDetails,
  });
  
}