import 'sale_tax.dart';

class PosSettings {
  final bool tax;
  final bool discountOnBill;
  final List<SaleTax> taxOrder;

  PosSettings({required this.tax, required this.discountOnBill, required this.taxOrder});

  /// `tax` = false, 
  /// `discountOnBill` = false, 
  /// `taxOrder` = [].
  factory PosSettings.none() {
    return PosSettings(tax: false, discountOnBill: false, taxOrder: []);
  }
}