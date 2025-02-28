// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../core/common/enums/common_enums.dart';

class SaleDiscount {

  final String discountName;

  final double discountValue;

  final DiscountType discountType;

  SaleDiscount({
    required this.discountName,
    required this.discountValue,
    required this.discountType,
  });

  SaleDiscount copyWith({
    String? discountName,
    double? discountValue,
    DiscountType? discountType,
  }) {
    return SaleDiscount(
      discountName: discountName ?? this.discountName,
      discountValue: discountValue ?? this.discountValue,
      discountType: discountType ?? this.discountType,
    );
  }

  @override
  String toString() {
    return 'SaleDiscount(discountName: $discountName, discountValue: $discountValue, discountType: $discountType)';
  }

  @override
  bool operator ==(covariant SaleDiscount other) {
    if (identical(this, other)) return true;
  
    return 
      other.discountName == discountName &&
      other.discountValue == discountValue &&
      other.discountType == discountType;
  }

  @override
  int get hashCode {
    return discountName.hashCode ^
      discountValue.hashCode ^
      discountType.hashCode;
  }
}
