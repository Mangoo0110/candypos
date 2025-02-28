import 'package:candypos/core/utils/uuid_service/firebase_uid.dart';
import 'package:candypos/features/pos/domain/entities/pos_settings.dart';
import 'package:candypos/core/common/notifiers/save_status_provider.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/common/domains/upload_meta.dart';
import '../../../../core/common/enums/common_enums.dart';
import '../../../../core/utils/func/dekhao.dart';
import '../../../auth/domain/entities/user_auth.dart';
import '../../domain/entities/addon.dart';
import '../../domain/entities/cart.dart';
import '../../domain/entities/delivery_info.dart';
import '../../domain/entities/payment.dart';
import '../../domain/entities/sale_customer.dart';
import '../../domain/entities/sale_discount.dart';
import '../../domain/entities/sale_item.dart';
import '../../domain/entities/sale_tax.dart';
import 'cart_item.dart';
import 'item_add_on.dart';


extension on ItemAddOn {
  AddOn toAddOn(ItemAddOn itemAddOn) {
    return AddOn(
      name: itemAddOn.name,
      price: itemAddOn.price,
      quantity: itemAddOn.quantity,
    );
  }
}


extension ToCartItem on SaleItem {
  CartItem toCartItem() {
    return CartItem(
      itemId: itemId,
      variantId: variantId,
      sku: sku,
      itemBarcode: itemBarcode,
      itemName: itemName,
      variantName: variantName,
      price: price,
      discount: 0,
      unitDetails: unitDetails,
      quantity: quantity,
      totalPrice: totalPrice,
      addedAddOns: addOns.map((e) => ItemAddOn(name: e.name, price: e.price, quantity: e.quantity, totalprice: e.price * e.quantity)).toList(),
      note: note,
    );
  }
}

class OpenedCart extends ChangeNotifier {
  late Key _key;

  PosSettings? _posSettings;

  late SaveStatusNotifier _saveStatusNotifier;
  SaveStatusNotifier get saveStatusNotifier => _saveStatusNotifier;

  late String _billId;

  ServiceType _serviceType = ServiceType.inStore;
  ServiceType get serviceType => _serviceType;
  set serviceType(ServiceType serviceType) {
    if (serviceType == _serviceType) return;
    _serviceType = serviceType;
    notifyListeners();
  }

  List<String> _servicedByIds = [];
  List<String> get servicedByIds => _servicedByIds;

  CustomerInfo? _customerInfo;
  CustomerInfo? get customerInfo => _customerInfo;
  set customerInfo(CustomerInfo? customerInfo) {
    _customerInfo = customerInfo;
    notifyListeners();
  }

  late List<SaleItem> _saleItemList;
  List<SaleItem> get saleItemList => _saleItemList;

  late double _subTotal;
  double get subTotal => _subTotal;

  SaleDiscount? _saleDiscount;
  SaleDiscount? get saleDiscount => _saleDiscount;

  late Map<int, SaleTax> _idMappedTax;
  Map<int, SaleTax> get idMappedTax => _idMappedTax;

  late double _grandTotal;
  double get grandTotal => _grandTotal;

  late List<Payment> _paymentList;
  List<Payment> get paymentList => _paymentList;

  late double _totalPaid;
  double get totalPaid => _totalPaid;

  late double _dueAmount;
  double get dueAmount => _dueAmount;

  DeliveryInfo? _deliveryInfo;
  DeliveryInfo? get deliveryInfo => _deliveryInfo;

  UploadMeta? _uploadMetaDetails;
  UploadMeta? get uploadMetaDetails => _uploadMetaDetails;

  double _totalDiscountAmount = 0;

  late double _totalTax;
  double get totalTax => _totalTax;

  static OpenedCart? _instance;
  static OpenedCart get instance {
    _instance ??= OpenedCart._();
    return _instance!;
  }

  OpenedCart._() {
    _key = Key("Cart${DateTime.now().toIso8601String()}");
    _saveStatusNotifier = SaveStatusNotifier(_key);
    init();
  }

  init({Cart? savedCart, PosSettings? settings}) {

    _posSettings = settings;
    _billId = savedCart?.id ?? uuidByFirebaseSdk();
    _serviceType = savedCart?.serviceType ?? ServiceType.inStore;
    _servicedByIds = savedCart?.servicedByIds ?? [];
    _customerInfo = savedCart?.customerInfo;
    _saleItemList = savedCart?.saleItemList ?? [];
    _subTotal = savedCart?.subTotal ?? 0;
    _saleDiscount = savedCart?.saleDiscount;
    _idMappedTax = savedCart?.idMappedTax ?? {};
    _grandTotal = savedCart?.grandTotal ?? 0;
    _paymentList = [];
    _totalPaid = 0;
    _dueAmount = 0;
    _deliveryInfo = savedCart?.deliveryInfo;
    _uploadMetaDetails = savedCart?.uploadMetaDetails;
    _totalDiscountAmount = 0;
    _totalTax = 0;
    if (savedCart != null) {
      _instance = OpenedCart._(
        
      );
      return _instance!;
    }
  }

  /// process =>>
  ///
  /// _doSubtotal();
  ///
  /// _doDiscount();
  ///
  /// _grandTotal = _subTotal - _totalDiscountAmount + _totalTax + _deliveryCharge;
  ///
  /// _doBalance();
  void doTotal() {
    _doSubtotal();
    _doDiscount();
    _grandTotal = _subTotal -
        _totalDiscountAmount +
        _totalTax +
        (deliveryInfo?.deliveryCharge ?? 0);
    
    dekhao("grand total $_grandTotal");
    _doBalance();
    notifyListeners();
  }

  void _doBalance() {
    double totalPaidAmount = 0;
    for (final payment in paymentList) {
      totalPaidAmount += payment.amount;
    }
    _totalPaid = totalPaidAmount;
    _dueAmount = _grandTotal - _totalPaid;
  }

  void _doSubtotal() {
    _subTotal = 0;
    dekhao("before adding $_subTotal");
    for (final saleItem in saleItemList) {
      _subTotal += saleItem.totalPrice;
      dekhao("adding ${saleItem.price} , after adding $_subTotal");
    }
  }

  void _doDiscount() {
    _totalDiscountAmount = (_saleDiscount == null
        ? 0
        : _saleDiscount!.discountType == DiscountType.flat
            ? _saleDiscount!.discountValue
            : (_subTotal * (_saleDiscount!.discountValue / 100)));
  }

  void setCustomer({required CustomerInfo? customerInfo}) {
    _customerInfo = customerInfo;
    notifyListeners();
  }

  /// Returns true, if dueAmount > 0 and adding payment's paidAmount > 0.
  /// Otherwise, returns false
  bool addPayment({required Payment payment}) {
    if (dueAmount > 0 && payment.amount > 0) {
      _paymentList.add(payment);
      _doBalance();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  void removeAllItems() {
    _saleItemList = [];
    doTotal();
  }


  void addItem({required SaleItem saleItem}) {
    
    dekhao("adding item ${saleItem.itemName}");
    final itemIndex = _saleItemList.indexWhere((e) => e.variantId == saleItem.variantId && e.addOns.isEmpty);

    if(itemIndex != -1){
      _saleItemList[itemIndex] = _saleItemList[itemIndex].copyWith(quantity: _saleItemList[itemIndex].quantity + 1);
      doTotal();
      notifyListeners();
    } else {

      _saleItemList.add(saleItem);
      doTotal();
      notifyListeners();
    }
    
  }


  void editItemAt({required SaleItem saleItem, required int index}) {
    if (_saleItemList.length - 1 < index || index < 0) {
      return;
    }
    _saleItemList[index] = saleItem;
    doTotal();
  }


  /// The [index] must be in the range `0 ≤ index < length`.
  /// The list must be growable.
  void removeItemAt({required int index}) {
    if (_saleItemList.length - 1 < index || index < 0) {
      return;
    }
    _saleItemList.removeAt(index);
    doTotal();
  }

  bool _saleItemListIndexError(int index) {
    if (index < 0 || _saleItemList.length - 1 < index) {
      return false;
    }
    return true;
  }

  /// If returns null, it means ready to checkout;
  /// Else returns the error.
  String? _checkIfCanCheckout() {
    if (_billId.isEmpty) {
      if (_saveStatusNotifier.saveStatus != SaveStatus.canNotSave) {
        _saveStatusNotifier.setSaveStatus(_key, SaveStatus.canNotSave);
      }
      return "Order's bill id is null!";
    }

    if (saleItemList.isEmpty) {
      if (_saveStatusNotifier.saveStatus != SaveStatus.canNotSave) {
        _saveStatusNotifier.setSaveStatus(_key, SaveStatus.canNotSave);
      }
      return "Can't checkout with an empty cart";
    }

    final deliveryError = _deliveryInfoFilled();

    if (deliveryError != null) {
      if (_saveStatusNotifier.saveStatus != SaveStatus.canNotSave) {
        _saveStatusNotifier.setSaveStatus(_key, SaveStatus.canNotSave);
      }
      return deliveryError;
    }

    if (_saveStatusNotifier.saveStatus != SaveStatus.canSave) {
      _saveStatusNotifier.setSaveStatus(_key, SaveStatus.canSave);
    }
  }

  String? _deliveryInfoFilled() {
    if (_serviceType == ServiceType.delivery) {
      if (_deliveryInfo == null) {
        return "Delivery info is not set.";
      }

      if (_customerInfo == null) {
        return "Customer info is not set.";
      }
    }
    return null;
  }

  Future<void> checkout(UserAuth auth) async {
    _checkIfCanCheckout();
    if (_saveStatusNotifier.saveStatus != SaveStatus.canSave) return;
    init();
    notifyListeners();
  }
}
