import 'dart:async';


import 'package:candypos/core/api_handler/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/common/functions/handle_dartz.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../../core/utils/func/dekhao.dart';
import '../../../../init_dependency.dart';
import '../../domain/entities/store.dart';
import '../../domain/usecases/fetch_all_stores_of_user.dart';
import '../../domain/usecases/fetch_store.dart';
import '../../domain/usecases/open_store_local_db.dart';
import '../../domain/usecases/save_as_current_branch.dart';



class StoreDataProvider extends ChangeNotifier{

  Store? _currentStore;

  List<Store> _storesOfUser = [];

  DateTime _storesOfUserFetchedAt = DateTime.now().copyWith(year: (DateTime.now().year - 1));

  Store? get currentStore => _currentStore;

  StoreDataProvider(){
    _init();
  }


  Future<void> _init() async{

    dekhao("Initializing branch data");
    await serviceLocator<OpenStoreLocalDb>().call(NoParams()).then((e) async{
      final result = handleDartz(dataResult: e);
      if(result == null) {
        dekhao("OpenStoreLocalDb call is failed!");
      } else {
        dekhao("OpenStoreLocalDb call is successful.");
      }
      //await fetchCurrentStore();
    });
    

  }
  


  Future<Store?> fetchCurrentStore({bool? forceFetch}) async{
    
    if(forceFetch != true && _currentStore != null) return _currentStore;

    return await serviceLocator<FetchCurrentStore>().call(NoParams()).then((dataResult) {

      return dataResult.fold((l) {
        dekhao("Error: ${l.message}");
        Fluttertoast.showToast(msg: "Error: ${l.message}");
        return null;
      }, (r) {
        _currentStore = r; notifyListeners(); 
        return r;
      });
    });
  }


  Future<List<Store>> fetchAllStoresOfUser(bool? forceFetch) async{

    if((DateTime.now().millisecondsSinceEpoch - _storesOfUserFetchedAt.millisecondsSinceEpoch) / 60 < 6 && forceFetch != true) return _storesOfUser;
    return await serviceLocator<FetchAllStoresOfUser>().call(NoParams()).then((value) {
      return value.fold(
        (l) {
          return [];
        }, 
        (r) {
        _storesOfUser = r; notifyListeners();
        return r;
      });
    });

  }


  Future<bool> saveAsCurrentStore({required Store store}) async{
    return await serviceLocator<SaveAsCurrentStore>().call(store).then((value) {
      return value.fold((l) {
        dekhao("Error: $l");
        Fluttertoast.showToast(msg: "Error: $l");
        return false;
      }, (r) {
        _currentStore = store;
        notifyListeners();
        return true;
      });
    });
  }

}