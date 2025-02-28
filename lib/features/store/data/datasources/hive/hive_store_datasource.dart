import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

import '../../../domain/usecases/update_store_info.dart';
import '../../models/store_model.dart';

abstract interface class LocalStoreDatasource {
  Future<void> openDb();

  Future<void> saveAsCurrentStore({required StoreModel storeModel});

  Future<void> updateStoreInfo({
    required UpdateStoreInfoParams updateStoreInfoParams
  });

  /// ****This is an offline feature only. All of the other features data except Store data will be deleted too.****
  Future<void> logoutFromCurrentStore();

  Stream<StoreModel?> currentStoreStream();

  Future<StoreModel?> getcurrentStoreInfo();

  void dispose();
}

class StoreHiveImpl implements LocalStoreDatasource {
  
  StoreModel? _currentStore;
  StoreModel? get currentStore => _currentStore;

  //late Stream<StoreModel?> _currentStore;

  Box<dynamic>? _box;

  static String? _onlyDataKey;

  static StoreHiveImpl? _instance;

  StoreHiveImpl._internal();

  static StoreHiveImpl get instance {
    _instance ??= StoreHiveImpl._internal();
    return _instance!;
  }


  @override
  Future<void> openDb() async {
    final currentAuth = FirebaseAuth.instance.currentUser;

    if(currentAuth == null) {
      throw Exception("User auth is not found!");
    }
    String boxName = '${currentAuth.uid}|Store';
    _onlyDataKey = '${currentAuth.uid}|Store';
    _box ??= await Hive.openBox(boxName);
  }

  @override
  Future<void> saveAsCurrentStore({required StoreModel storeModel}) async {
    _isBoxNull();

    return await _box?.clear().then((_) async {
      return await _box?.put(storeModel.id, storeModel.toMap());
    });
  }

  

  @override
  Future<void> logoutFromCurrentStore() async {
    _isBoxNull();

    await _box?.clear().then((e) {
      _currentStore = null;
    });
  }



  Stream<BoxEvent> _watchBoxChanges() {
    return _box!.watch();
  }

  @override
  Stream<StoreModel?> currentStoreStream() async* {
    _isBoxNull();

    yield await getcurrentStoreInfo(); // Emit initial state

    await for (final boxEvent in _watchBoxChanges()) {
      yield boxEvent.deleted
          ? null
          : StoreModel.fromJson(
              jsonEncode(boxEvent.value)); // Emit updated list on each change
    }
  }


  @override
  Future<StoreModel?> getcurrentStoreInfo() async {
    _isBoxNull();

    final result = _box!.values.first;
    if (result == null) return null;
    _currentStore = StoreModel.fromJson(jsonEncode(result));
    return _currentStore;
  }

  @override
  void dispose() {
    if (_box != null) _box!.close();
  }

  void _isBoxNull() {
    if (_box == null) {
      throw Exception(
          "Local db is not open!!! First you need to open the db before accessing any db service.");
    }
  }

  @override
  Future<void> updateStoreInfo({
    required UpdateStoreInfoParams updateStoreInfoParams
  }) async {
    // TODO: implement updateStoreInfo
  }
}
