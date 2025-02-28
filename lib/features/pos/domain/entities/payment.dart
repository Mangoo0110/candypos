// ignore_for_file: public_member_api_docs, sort_constructors_first


import '../../../../core/common/enums/common_enums.dart';

class Payment {
  final String? transactionId;
  final PaymentMethod? paymentMethod;
  final double amount;
  final DateTime transactionAt;

  Payment({required this.transactionId, required this.paymentMethod, required this.amount, required this.transactionAt});



  Payment copyWith({
    String? transactionId,
    PaymentMethod? paymentMethod,
    double? amount,
    DateTime? transactionAt,
  }) {
    return Payment(
      transactionId: transactionId ?? this.transactionId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      amount: amount ?? this.amount,
      transactionAt: transactionAt ?? this.transactionAt,
    );
  }

  @override
  String toString() {
    return 'Payment(transactionId: $transactionId, paymentMethod: $paymentMethod, amount: $amount, transactionAt: $transactionAt)';
  }

  @override
  bool operator ==(covariant Payment other) {
    if (identical(this, other)) return true;
  
    return 
      other.transactionId == transactionId &&
      other.paymentMethod == paymentMethod &&
      other.amount == amount &&
      other.transactionAt == transactionAt;
  }

  @override
  int get hashCode {
    return transactionId.hashCode ^
      paymentMethod.hashCode ^
      amount.hashCode ^
      transactionAt.hashCode;
  }
}
