// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddOn {
  /// Name of the add_on group. Default is "Custom".
  final String group;

  final String name;

  final double price;

  final double quantity;


  // Constructor
  AddOn({
    this.group = "Custom",
    required this.name,
    required this.price,
    required this.quantity,
  });


  @override
  String toString() {
    return 'Modifier(group: $group, name: $name, price: $price, quantity: $quantity,)';
  }

  @override
  bool operator ==(covariant AddOn other) {
    if (identical(this, other)) return true;
  
    return 
      other.group == group &&
      other.name == name &&
      other.price == price &&
      other.quantity == quantity;
  }

  @override
  int get hashCode {
    return group.hashCode ^
      name.hashCode ^
      price.hashCode ^
      quantity.hashCode;
  }

  AddOn copyWith({
    String? group,
    String? name,
    double? price,
    double? quantity,
  }) {
    return AddOn(
      group: group ?? this.group,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
