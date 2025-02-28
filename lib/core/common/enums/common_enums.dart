import 'package:flutter/material.dart';

enum SaveStatus {canSave, canNotSave, saving, success, failed}

enum DeleteStatus {canDelete, canNotDelete, deleting, deleted, failed}

enum Gender {male, female, other}

enum FetchingStatus {
  fetching, fetched
}



enum TaxType {
  value,
  percentage;


  factory TaxType.tryParse(String name) {

    for(final val in TaxType.values) {
      if(val.name == name) return val;
    }

    throw Exception("Failed to parse($name) TaxType!");
  }
}


enum DiscountType {
  percentage, 
  flat;

  factory DiscountType.tryParse(String name) {

    for(final val in DiscountType.values) {
      if(val.name == name) return val;
    }

    throw Exception("Failed to parse($name) DiscountType!");
  }
}

enum ServiceType {
  inStore,

  walkIn, 

  delivery, 
  
  pickup,;

  factory ServiceType.tryParse(String name) {
    for(final val in ServiceType.values) {
      if(val.name == name) return val;
    }

    throw Exception("Failed to parse($name) ServiceType!");
  }

  IconData get icon {
    switch(this) {
      case ServiceType.walkIn: return Icons.directions_walk;
      case ServiceType.delivery: return Icons.local_shipping;
      case ServiceType.inStore: return Icons.storefront;
      case ServiceType.pickup: return Icons.takeout_dining;
    }
  }

  String get name {
    switch(this) {
      case ServiceType.walkIn: return "Walk-In";
      case ServiceType.delivery: return "Delivery";
      case ServiceType.inStore: return "In-Store";
      case ServiceType.pickup: return "Pickup";
    }
  }
}

enum OnlineStatus {

  offline, 

  processing, 
  
  online;

  factory OnlineStatus.tryParse(String name) {
    for(final val in OnlineStatus.values) {
      if(val.name == name) return val;
    }
    throw Exception("Failed to parse($name) OnlineStatus!");
  }
}

enum BillingMethod {
  keypad,

  itemSelect,

  scan;

  factory BillingMethod.tryParse(String name) {
    for(final val in BillingMethod.values) {
      if(val.name == name) return val;
    }
    throw Exception("Failed to parse($name) BillingMethod!");
  }
}

enum BillStatus {
  onService,
  
  onHold, 

  refunded, 
  
  processed;


  factory BillStatus.tryParse(String name) {
    for(final val in BillStatus.values) {
      if(val.name == name) return val;
    }
    throw Exception("Failed to parse($name) BillStatus!");
  }
}


enum PaymentMethod {
  cash,

  visa,

  mastercard,

  bkash,

  nogod,

  card,

  mobileBanking,

  other,

  onHouse;


  factory PaymentMethod.tryParse(String name) {
    for(final val in PaymentMethod.values) {
      if(val.name == name) return val;
    }
    throw Exception("Failed to parse($name) PaymentMethod!");
  }
}


enum DeliveryPhase {
  processing,

  ready,

  delivered;

  factory DeliveryPhase.tryParse(String name) {
    for(final val in DeliveryPhase.values) {
      if(val.name == name) return val;
    }
    throw Exception("Failed to parse($name) DeliveryPhase!");
  }
}