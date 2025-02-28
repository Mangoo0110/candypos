

class CustomerInfo {

  final String customerId;
  
  final String name;

  final String? contactNo;

  final String? customerAddress;

  CustomerInfo({required this.customerId, required this.name, required this.contactNo, required this.customerAddress});


  CustomerInfo copyWith({
    String? customerId,
    String? name,
    String? contactNo,
    String? customerAddress,
  }) {
    return CustomerInfo(
      customerId: customerId ?? this.customerId,
      name: name ?? this.name,
      contactNo: contactNo ?? this.contactNo,
      customerAddress: customerAddress ?? this.customerAddress,
    );
  }

  @override
  String toString() {
    return 'SaleCustomer(customerId: $customerId, name: $name, contactNo: $contactNo, customerAddress: $customerAddress)';
  }

  @override
  bool operator ==(covariant CustomerInfo other) {
    if (identical(this, other)) return true;
  
    return 
      other.customerId == customerId &&
      other.name == name &&
      other.contactNo == contactNo &&
      other.customerAddress == customerAddress;
  }

  @override
  int get hashCode {
    return customerId.hashCode ^
      name.hashCode ^
      contactNo.hashCode ^
      customerAddress.hashCode;
  }
}
