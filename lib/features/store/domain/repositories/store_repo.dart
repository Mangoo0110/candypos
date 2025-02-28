import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../entities/store.dart';
import '../usecases/update_store_info.dart';

abstract interface class StoreRepo {

  Future<Either<DataCRUDFailure, Success>> openLocalDb();


  /// **Both offline and online.**
  Future<Either<DataCRUDFailure, Success>> createNewStore({
    required Store store,
  });

  Future<Either<DataCRUDFailure, Success>> updateStoreInfo({
    required UpdateStoreInfoParams updateStoreInfoParams
  });

  /// Saves provided [store] as current brunch for this device.
  ///
  /// **Offline caching only.**
  Future<Either<DataCRUDFailure, Success>> saveAsCurrentStore({
    required Store store,
  });

  /// Deleting brunch will trigger to delete all of its related/child data collection of features.
  ///
  /// **Both offline and online.**
  Future<Either<DataCRUDFailure, Success>> deleteStore({
    required String storeId,
  });

  /// Current brunch logout will trigger to remove all of its related data collection of features from local storage.
  ///
  /// **Offline logout.**
  Future<Either<DataCRUDFailure, Success>> logoutFromCurrentBrunch();

  /// Tries to refresh store data. If not returns local data.
  ///
  /// **Both offline and online.**
  Future<Either<DataCRUDFailure, Store?>> fetchCurrentStore();

  /// **Online fetching only. Should be connected to the internet.**
  /// Fetches all stores of user from remote database.
  Future<Either<DataCRUDFailure, List<Store>>> fetchAllStoreOfUser();
}
