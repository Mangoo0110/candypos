
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Money {
  final List<int> _currencies = [1, 2, 5, 10, 20, 50, 100, 200, 500, 1000];

  List<int> get currencies => _currencies;


  String moneyText({required double moneyValue}) {

    NumberFormat format = NumberFormat.simpleCurrency(locale: "bn",);
    return '${format.currencyName ?? 'BDT'} ${moneyValue.toString()}';

  }

  String moneySymbol({required BuildContext context}) {

    NumberFormat format = NumberFormat.simpleCurrency(locale: 'bn');
    return format.currencySymbol;

  }
}