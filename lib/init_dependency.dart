import 'package:candypos/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../features/image/data/datasources/firebase/image_firebase_datasource.dart';
import '../features/image/data/repositories/image_repo_impl.dart';
import '../features/image/domain/usecases/delete_image.dart';
import '../features/image/domain/usecases/fetch_image.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

import 'features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repo_impl.dart';
import 'features/auth/domain/usecases/get_current_user.dart';
import 'features/auth/domain/usecases/user_is_logged_in.dart';
import 'features/auth/domain/usecases/user_signin.dart';
import 'features/auth/domain/usecases/user_signup.dart';
import 'features/image/data/datasources/hive/image_local_datasource.dart';
import 'features/image/domain/usecases/delete_image_from_local_db.dart';
import 'features/image/domain/usecases/fetch_image_from_local_db.dart';
import 'features/image/domain/usecases/save_image_locally.dart';
import 'features/image/domain/usecases/save_image_with_reference_path.dart';
import 'features/image/domain/usecases/save_image_with_url.dart';
import 'features/inventory/item/data/datasources/remote/item_remote_datasource.dart';
import 'features/inventory/item/data/repositories/item_repo_impl.dart';
import 'features/inventory/item/domain/usecases/create_item.dart';
import 'features/inventory/item/domain/usecases/delete_item.dart';
import 'features/inventory/item/domain/usecases/fetch_synced_items.dart';
import 'features/inventory/item/domain/usecases/update_item.dart';
import 'features/store/data/datasources/firebase/firebase_store_datasource.dart';
import 'features/store/data/datasources/hive/hive_store_datasource.dart';
import 'features/store/data/repositories/store_repo_impl.dart';
import 'features/store/domain/usecases/create_store.dart';
import 'features/store/domain/usecases/fetch_all_stores_of_user.dart';
import 'features/store/domain/usecases/fetch_store.dart';
import 'features/store/domain/usecases/open_store_local_db.dart';
import 'features/store/domain/usecases/save_as_current_branch.dart';
import 'features/user/data/datasources/local/user_local_datasource.dart';
import 'features/user/data/datasources/remote/user_remote_datasource.dart';
import 'features/user/data/repositories/user_repo_impl.dart';
import 'features/user/domain/usecases/fetch_current_user_info.dart';
import 'features/user/domain/usecases/fetch_user_info.dart';
import 'features/user/domain/usecases/open_user_info_local_db.dart';
import 'features/user/domain/usecases/save_user_info.dart';

final serviceLocator = GetIt.instance;

  //::: Datasources [register singletone]

  //::: Repo [register factory]

  //::: Usecases

Future<void> initDependencies()async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) async{
    //FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);
  });
  
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  firebaseFirestore.settings = Settings(persistenceEnabled: true);
  serviceLocator.registerSingleton(()=> firebaseFirestore);
  serviceLocator.registerSingleton(()=> FirebaseAuth.instance);
  _authService();
  _imageService();
  _userInfoService();
  _storeService();
  _itemService();
}


void _imageService() {
  //::: Remote Datasource [register singletone]
  serviceLocator.registerLazySingleton(() => ImageFirebaseStorageImpl.instance);

  //::: Local Datasource [register singletone]
  serviceLocator.registerLazySingleton(() => ImageHiveDatasouceImpl.instance);

  //::: Repo [register factory]
  serviceLocator.registerFactory(() => ImageRepoImpl(serviceLocator<ImageFirebaseStorageImpl>(), serviceLocator<ImageHiveDatasouceImpl>()));

  //::: Usecases
  serviceLocator.registerLazySingleton(() => DeleteImage(serviceLocator<ImageRepoImpl>()));
  serviceLocator.registerLazySingleton(() => DeleteImageFromLocalDb(serviceLocator<ImageRepoImpl>()));
  serviceLocator.registerLazySingleton(() => FetchImage(serviceLocator<ImageRepoImpl>()));
  serviceLocator.registerLazySingleton(() => FetchImageFromLocalDb(serviceLocator<ImageRepoImpl>()));
  serviceLocator.registerLazySingleton(() => SaveImageWithUrl(serviceLocator<ImageRepoImpl>()));
  serviceLocator.registerLazySingleton(() => SaveImageWithReferencePath(serviceLocator<ImageRepoImpl>()));
  serviceLocator.registerLazySingleton(() => SaveImageLocally(serviceLocator<ImageRepoImpl>()));
  
}


void _authService(){  
  
  serviceLocator.registerLazySingleton(() => AuthFirebaseImpl.instance);

  serviceLocator.registerFactory(() => AuthRepoImpl(serviceLocator<AuthFirebaseImpl>()));

  // usecases

  serviceLocator.registerLazySingleton(() => UserSignIn(serviceLocator<AuthRepoImpl>()));

  serviceLocator.registerLazySingleton(() => UserSignUp(serviceLocator<AuthRepoImpl>()));

  serviceLocator.registerLazySingleton(() => GetCurrentUserAuth(serviceLocator<AuthRepoImpl>()));

  serviceLocator.registerLazySingleton(() => IsUserSignedIn(serviceLocator<AuthRepoImpl>()));

}

void _userInfoService(){

  //::: Datasources [register singletone]  
  serviceLocator.registerLazySingleton(() => UserFirestoreImpl.instance);
  serviceLocator.registerLazySingleton(() => UserHiveImpl.instance);

  //::: Repo [register factory]
  serviceLocator.registerFactory(() => UserRepoImpl(serviceLocator<UserFirestoreImpl>(), serviceLocator<UserHiveImpl>()));

  //::: Usecases
  serviceLocator.registerLazySingleton(() => SaveUserInfo(serviceLocator<UserRepoImpl>()));
  serviceLocator.registerLazySingleton(() => OpenUserInfoLocalDb(serviceLocator<UserRepoImpl>()));
  serviceLocator.registerLazySingleton(() => FetchCurrentUserInfo(serviceLocator<UserRepoImpl>()));
  serviceLocator.registerLazySingleton(() => FetchUserInfo(serviceLocator<UserRepoImpl>()));
}



void _storeService() {

  RemoteStoreDatasource remoteStoreDatasource = StoreFirebaseImpl.instance;
  
  LocalStoreDatasource localStoreDatasource = StoreHiveImpl.instance;

  //::: Remote Datasource [register lazy singletone]
  serviceLocator.registerLazySingleton(()=> remoteStoreDatasource);

  //::: Local Datasource [register lazy singletone]
  serviceLocator.registerLazySingleton(()=> localStoreDatasource);

  //::: Repo [register factory]
  serviceLocator.registerFactory(()=> StoreRepoImpl(serviceLocator<RemoteStoreDatasource>(), serviceLocator<LocalStoreDatasource>()));

  //::: Usecases [register lazy singletone]
  serviceLocator.registerLazySingleton(() => FetchCurrentStore(serviceLocator<StoreRepoImpl>()));
  serviceLocator.registerLazySingleton(() => OpenStoreLocalDb(serviceLocator<StoreRepoImpl>()));
  serviceLocator.registerLazySingleton(() => CreateStore(serviceLocator<StoreRepoImpl>()));
  serviceLocator.registerLazySingleton(() => SaveAsCurrentStore(serviceLocator<StoreRepoImpl>()));
  serviceLocator.registerLazySingleton(() => FetchAllStoresOfUser(serviceLocator<StoreRepoImpl>()));
}


void _itemService() {
  
  //::: Datasources [register singletone]
  serviceLocator.registerLazySingleton<ItemRemoteDatasource>(() => ItemRemoteDatasourceImpl.instance);
  //serviceLocator.registerLazySingleton(() => itemHiveImpl);

  //::: Repo [register factory]
  serviceLocator.registerFactory(() => ItemRepoImpl(serviceLocator<ItemRemoteDatasource>()));

  //::: Usecases
  serviceLocator.registerLazySingleton(() => CreateItem(serviceLocator<ItemRepoImpl>()));
  serviceLocator.registerLazySingleton(() => UpdateItem(serviceLocator<ItemRepoImpl>()));
  serviceLocator.registerLazySingleton(() => DeleteItem(serviceLocator<ItemRepoImpl>()));
  serviceLocator.registerLazySingleton(() => FetchItems(serviceLocator<ItemRepoImpl>()));

}


// void _categoryService() {
//   VariantFirestoreImpl variantFirestoreImpl = VariantFirestoreImpl.instance;
//   VariantHiveImpl variantHiveImpl = VariantHiveImpl.instance;
  
//   //::: Datasources [register singletone]
//   serviceLocator.registerLazySingleton(() => variantFirestoreImpl);
//   serviceLocator.registerLazySingleton(() => variantHiveImpl);

//   //::: Repo [register factory]
//   serviceLocator.registerFactory(() => VariantRepoImpl(serviceLocator<VariantFirestoreImpl>(), serviceLocator<VariantHiveImpl>()));

//   //::: Usecases
//   serviceLocator.registerLazySingleton(() => SaveVariant(serviceLocator<VariantRepoImpl>()));
//   serviceLocator.registerLazySingleton(() => DeleteVariant(serviceLocator<VariantRepoImpl>()));
//   serviceLocator.registerLazySingleton(() => FetchAllVariants(serviceLocator<VariantRepoImpl>()));
//   serviceLocator.registerLazySingleton(() => GetNewVariantId(serviceLocator<VariantRepoImpl>()));
//   serviceLocator.registerLazySingleton(() => SyncVariants(serviceLocator<VariantRepoImpl>()));
// }



