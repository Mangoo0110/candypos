// ignore_for_file: public_member_api_docs, sort_constructors_first




class ItemAddOn {

  final String name;

  final double price;

  double _quantity;

  late double _totalprice;

  double get quantity => _quantity;
  set quantity(double value) {
    _quantity = value; _doTotal();
  }

  double get totalprice => _totalprice;

  ItemAddOn({required this.name, required this.price, required double quantity, required double? totalprice}) : _quantity = quantity{
    _totalprice = totalprice ?? _quantity * price;
  }


  _doTotal() {
    _totalprice = _quantity * price;
  }

  ItemAddOn copyWith({
    String? name,
    double? price,
    double? quantity,
    double? totalprice,
  }) {
    return ItemAddOn(
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this._quantity,
      totalprice: totalprice ?? this._totalprice,
    );
  }
}
