import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../../../../core/api_handler/trycatch.dart';
import '../../domain/entities/store.dart';
import '../../domain/repositories/store_repo.dart';
import '../../domain/usecases/update_store_info.dart';
import '../datasources/firebase/firebase_store_datasource.dart';
import '../datasources/hive/hive_store_datasource.dart';
import '../models/store_model.dart';

class StoreRepoImpl implements StoreRepo {

  final RemoteStoreDatasource _remoteStoreDatasource;

  final LocalStoreDatasource _localStoreDatasource;

  StoreRepoImpl(this._remoteStoreDatasource, this._localStoreDatasource);


  @override
  Future<Either<DataCRUDFailure, Success>> openLocalDb() async{
    return await asyncTryCatch<Success>(tryFunc: () async {
      return await _localStoreDatasource.openDb() .then((value) => Success(message: "Store is saved.."));
    });
  }

  @override
  Future<Either<DataCRUDFailure, Success>> createNewStore(
      {required Store store}) async {
    return await asyncTryCatch<Success>(tryFunc: () async {
      return await Future.wait([
        _remoteStoreDatasource.createStore(
            storeModel: StoreModel.fromEntity(store)),
      ]).then((value) => Success(message: "Store is saved.."));
    });
  }

  @override
  Future<Either<DataCRUDFailure, Success>> deleteStore(
      {required String storeId}) async {
    return await asyncTryCatch<Success>(tryFunc: () async {
      return await Future.wait([
        _remoteStoreDatasource.deleteStore(storeId: storeId),
      ]).then((value) => Success(message: "Deleted successfully."));
    });
  }

  /// Fetches all stores of user from remote database.
  @override
  Future<Either<DataCRUDFailure, List<Store>>> fetchAllStoreOfUser() async {
    return await asyncTryCatch<List<Store>>(tryFunc: () async {
      return await _remoteStoreDatasource.fetchAllStoresOfUser();
    });
  }

  @override
  Future<Either<DataCRUDFailure, Success>> saveAsCurrentStore(
      {required Store store}) async {
    return await asyncTryCatch<Success>(tryFunc: () async {
      return await _localStoreDatasource
          .saveAsCurrentStore(storeModel: StoreModel.fromEntity(store))
          .then((value) => Success(message: "Store logged out successfully."));
    });
  }

  @override
  Future<Either<DataCRUDFailure, Store?>> fetchCurrentStore() async {
    return await asyncTryCatch<Store?>(

        /// local
        /// call
        tryFunc: () async {
      // Fetching currentStore from local db.
      return await _localStoreDatasource
          .getcurrentStoreInfo()
          .then((value) async {
        Store? store = value;
        // Fetch up to date currentStore data from remote db and sync to local db.
        await asyncTryCatch<Store?>(
          tryFunc: () async {
            return await _remoteStoreDatasource
                .getStore(storeId: value!.id)
                .then((value) async {
              if (value != store && value != null) {
                store = value;
                // Sync to local db.
                await asyncTryCatch<void>(
                  tryFunc: () async {
                    return await _localStoreDatasource.saveAsCurrentStore(
                        storeModel: value);
                  },
                );
              }
              return store;
            });
          },
        );

        return store;
      });
    });
  }



  Future<Either<DataCRUDFailure, Store?>>
      _fetchCurrentStoreFromLocalDb() async {
    return asyncTryCatch<Store?>(tryFunc: () async {
      return await _localStoreDatasource.getcurrentStoreInfo();
    });
  }



  Future<Either<DataCRUDFailure, Store?>> _fetchStoreFromRemoteDb(
      String storeId) async {
    return asyncTryCatch<Store?>(tryFunc: () async {
      return await _remoteStoreDatasource.getStore(storeId: storeId);
    });
  }



  @override
  Future<Either<DataCRUDFailure, Success>> logoutFromCurrentBrunch() async {
    return await asyncTryCatch<Success>(tryFunc: () async {
      return await _localStoreDatasource
          .logoutFromCurrentStore()
          .then((value) => Success(message: "Store logged out successfully."));
    });
  }



  @override
  Future<Either<DataCRUDFailure, Success>> updateStoreInfo({
    required UpdateStoreInfoParams updateStoreInfoParams
  }) async {
    return await asyncTryCatch<Success>(tryFunc: () async {
      
      return await _updateStoreInfoInLocalDb(
            updateStoreInfoParams: updateStoreInfoParams
          )
          .then((_) => Success(message:  "Store info is updated."));
    });
  }


  @override
  Future<Either<DataCRUDFailure, Success>> _updateStoreInfoInRemoteDb({
    required UpdateStoreInfoParams updateStoreInfoParams
  }) async {
    return await asyncTryCatch<Success>(tryFunc: () async {
      return await _remoteStoreDatasource
          .updateStoreInfo(
            updateStoreInfoParams: updateStoreInfoParams
          )
          .then((_) => Success(message:  "Store info is updated."));
    });
  }


  @override
  Future<Either<DataCRUDFailure, Success>> _updateStoreInfoInLocalDb({
    required UpdateStoreInfoParams updateStoreInfoParams
  }) async {
    return await asyncTryCatch<Success>(tryFunc: () async {
      return await _localStoreDatasource
          .updateStoreInfo(
            updateStoreInfoParams: updateStoreInfoParams
          )
          .then((_) => Success(message:  "Store info is updated."));
    });
  }


}
