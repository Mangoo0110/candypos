// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:candypos/features/auth/domain/entities/user_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/common/domains/upload_meta.dart';
import '../../../../core/common/enums/common_enums.dart';
import 'delivery_info.dart';
import 'payment.dart';
import 'sale_customer.dart';
import 'sale_discount.dart';
import 'sale_item.dart';
import 'sale_tax.dart';

class OrderBill {
  final String billId;

  final ServiceType billType;

  final List<String> servicedByIds;

  final CustomerInfo? customerInfo;

  final DeliveryInfo? deliveryInfo;

  final List<SaleItem> saleItemList;

  final double deliveryCharge;

  final double subTotal;

  final SaleDiscount? saleDiscount;

  final double afterDiscountTotal;

  final Map<int, SaleTax> idMappedTax;

  final double afterTaxTotal;

  final double grandTotal;

  final List<Payment> paymentList;

  final double totalPaid;

  final double dueAmount;

  final DateTime billedAt;

  final BillStatus billingStatus;

  final UploadMeta uploadMetaDetails;

  OrderBill({
    required this.billId,
    required this.billType,
    required this.servicedByIds,
    required this.customerInfo,
    required this.deliveryInfo,
    required this.saleItemList,
    required this.deliveryCharge,
    required this.subTotal,
    required this.saleDiscount,
    required this.afterDiscountTotal,
    required this.idMappedTax,
    required this.afterTaxTotal,
    required this.grandTotal,
    required this.paymentList,
    required this.totalPaid,
    required this.dueAmount,
    required this.billedAt,
    required this.billingStatus,
    required this.uploadMetaDetails,
  });

  OrderBill copyWith({
    String? billId,
    ServiceType? billType,
    List<String>? servicedByIds,
    CustomerInfo? customerInfo,
    DeliveryInfo? deliveryInfo,
    List<SaleItem>? saleItemList,
    double? deliveryCharge,
    double? subTotal,
    SaleDiscount? saleDiscount,
    double? afterDiscountTotal,
    Map<int, SaleTax>? idMappedTax,
    double? afterTaxTotal,
    double? grandTotal,
    List<Payment>? paymentList,
    double? totalPaid,
    double? dueAmount,
    DateTime? billedAt,
    BillStatus? billingStatus,
    UploadMeta? uploadMetaDetails,
  }) {
    return OrderBill(
      billId: billId ?? this.billId,
      billType: billType ?? this.billType,
      servicedByIds: servicedByIds ?? this.servicedByIds,
      customerInfo: customerInfo ?? this.customerInfo,
      deliveryInfo: deliveryInfo ?? this.deliveryInfo,
      saleItemList: saleItemList ?? this.saleItemList,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      subTotal: subTotal ?? this.subTotal,
      saleDiscount: saleDiscount ?? this.saleDiscount,
      afterDiscountTotal: afterDiscountTotal ?? this.afterDiscountTotal,
      idMappedTax: idMappedTax ?? this.idMappedTax,
      afterTaxTotal: afterTaxTotal ?? this.afterTaxTotal,
      grandTotal: grandTotal ?? this.grandTotal,
      paymentList: paymentList ?? this.paymentList,
      totalPaid: totalPaid ?? this.totalPaid,
      dueAmount: dueAmount ?? this.dueAmount,
      billedAt: billedAt ?? this.billedAt,
      billingStatus: billingStatus ?? this.billingStatus,
      uploadMetaDetails: uploadMetaDetails ?? this.uploadMetaDetails,
    );
  }

  factory OrderBill.empty(UserAuth auth) {
    return OrderBill(
      billId: auth.id,
      billType: ServiceType.inStore, // Replace with a default value for BillType
      servicedByIds: [],
      customerInfo: null,
      deliveryInfo: null,
      saleItemList: [],
      deliveryCharge: 0.0,
      subTotal: 0.0,
      saleDiscount: null,
      afterDiscountTotal: 0.0,
      idMappedTax: {},
      afterTaxTotal: 0.0,
      grandTotal: 0.0,
      paymentList: [],
      totalPaid: 0.0,
      dueAmount: 0.0,
      billedAt: DateTime.now(),
      billingStatus: BillStatus.onService, // Replace with a default value for BillStatus
      uploadMetaDetails: UploadMeta.newInstance(auth: auth), // Assuming UploadMeta has an empty constructor
    );
  }

  @override
  String toString() {
    return 'Bill(billId: $billId, billType: $billType, servicedByIds: $servicedByIds, customerInfo: $customerInfo, deliveryInfo: $deliveryInfo, saleItemList: $saleItemList, deliveryCharge: $deliveryCharge, subTotal: $subTotal, saleDiscount: $saleDiscount, afterDiscountTotal: $afterDiscountTotal, idMappedTax: $idMappedTax, afterTaxTotal: $afterTaxTotal, grandTotal: $grandTotal, paymentList: $paymentList, totalPaid: $totalPaid, dueAmount: $dueAmount, billedAt: $billedAt, billingStatus: $billingStatus, uploadMetaDetails: $uploadMetaDetails)';
  }

  @override
  bool operator ==(covariant OrderBill other) {
    if (identical(this, other)) return true;
  
    return 
      other.billId == billId &&
      other.billType == billType &&
      listEquals(other.servicedByIds, servicedByIds) &&
      other.customerInfo == customerInfo &&
      other.deliveryInfo == deliveryInfo &&
      listEquals(other.saleItemList, saleItemList) &&
      other.deliveryCharge == deliveryCharge &&
      other.subTotal == subTotal &&
      other.saleDiscount == saleDiscount &&
      other.afterDiscountTotal == afterDiscountTotal &&
      mapEquals(other.idMappedTax, idMappedTax) &&
      other.afterTaxTotal == afterTaxTotal &&
      other.grandTotal == grandTotal &&
      listEquals(other.paymentList, paymentList) &&
      other.totalPaid == totalPaid &&
      other.dueAmount == dueAmount &&
      other.billedAt == billedAt &&
      other.billingStatus == billingStatus &&
      other.uploadMetaDetails == uploadMetaDetails;
  }

  @override
  int get hashCode {
    return billId.hashCode ^
      billType.hashCode ^
      servicedByIds.hashCode ^
      customerInfo.hashCode ^
      deliveryInfo.hashCode ^
      saleItemList.hashCode ^
      deliveryCharge.hashCode ^
      subTotal.hashCode ^
      saleDiscount.hashCode ^
      afterDiscountTotal.hashCode ^
      idMappedTax.hashCode ^
      afterTaxTotal.hashCode ^
      grandTotal.hashCode ^
      paymentList.hashCode ^
      totalPaid.hashCode ^
      dueAmount.hashCode ^
      billedAt.hashCode ^
      billingStatus.hashCode ^
      uploadMetaDetails.hashCode;
  }
}
