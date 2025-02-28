// ignore_for_file: public_member_api_docs, sort_constructors_first


import '../../../../core/common/enums/common_enums.dart';

class DeliveryInfo {

  final DateTime deliveryAt;

  final String address;

  final DeliveryPhase deliveryPhase;

  final double deliveryCharge;
  DeliveryInfo({
    required this.deliveryAt,
    required this.address,
    required this.deliveryPhase,
    required this.deliveryCharge,
  });

  

  DeliveryInfo copyWith({
    DateTime? deliveryAt,
    String? address,
    DeliveryPhase? deliveryPhase,
    double? deliveryCharge,
  }) {
    return DeliveryInfo(
      deliveryAt: deliveryAt ?? this.deliveryAt,
      address: address ?? this.address,
      deliveryPhase: deliveryPhase ?? this.deliveryPhase,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
    );
  }

  @override
  String toString() {
    return 'DeliveryInfo(deliveryAt: $deliveryAt, address: $address, deliveryPhase: $deliveryPhase, deliveryCharge: $deliveryCharge)';
  }

  @override
  bool operator ==(covariant DeliveryInfo other) {
    if (identical(this, other)) return true;
  
    return 
      other.deliveryAt == deliveryAt &&
      other.address == address &&
      other.deliveryPhase == deliveryPhase &&
      other.deliveryCharge == deliveryCharge;
  }

  @override
  int get hashCode {
    return deliveryAt.hashCode ^
      address.hashCode ^
      deliveryPhase.hashCode ^
      deliveryCharge.hashCode;
  }
}
