import 'package:flutter/material.dart';

import '../pages/appdrawer.dart';

class AppdrawerStateController extends ChangeNotifier {
  AppDrawerTabState _selectedAppDrawerTab = AppDrawerTabState.pos;

  AppdrawerStateController();

  AppDrawerTabState get selectedAppDrawerTab => _selectedAppDrawerTab;

  changeAppDrawerTab(AppDrawerTabState selectedAppDrawerTab) {
    _selectedAppDrawerTab = selectedAppDrawerTab;
    notifyListeners();
  }
}