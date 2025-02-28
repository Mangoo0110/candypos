


// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../../../core/common/enums/common_enums.dart';

class SaleTax {
  final String taxId;

  final String taxName;

  final double taxValue;

  final TaxType taxType;

  SaleTax({required this.taxId, required this.taxName, required this.taxValue, required this.taxType});

  

  SaleTax copyWith({
    String? taxId,
    String? taxName,
    double? taxValue,
    TaxType? taxType,
  }) {
    return SaleTax(
      taxId: taxId ?? this.taxId,
      taxName: taxName ?? this.taxName,
      taxValue: taxValue ?? this.taxValue,
      taxType: taxType ?? this.taxType,
    );
  }

  @override
  String toString() {
    return 'SaleTax(taxId: $taxId, taxName: $taxName, taxValue: $taxValue, taxType: $taxType)';
  }

  @override
  bool operator ==(covariant SaleTax other) {
    if (identical(this, other)) return true;
  
    return 
      other.taxId == taxId &&
      other.taxName == taxName &&
      other.taxValue == taxValue &&
      other.taxType == taxType;
  }

  @override
  int get hashCode {
    return taxId.hashCode ^
      taxName.hashCode ^
      taxValue.hashCode ^
      taxType.hashCode;
  }
}

