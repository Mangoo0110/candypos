// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:candypos/core/usecases/usecases.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../core/common/functions/handle_dartz.dart';
import '../../core/utils/func/dekhao.dart';
import '../../features/auth/domain/entities/user_auth.dart';
import '../../features/store/domain/entities/store.dart';
import '../../features/store/ui/providers/store_data_provider.dart';
import '../../features/user/domain/entities/user_prv.dart';
import '../../features/user/domain/entities/user_pub.dart';
import '../../features/user/domain/usecases/fetch_current_user_info.dart';
import '../../features/user/domain/usecases/fetch_user_info.dart';
import '../../features/user/domain/usecases/open_user_info_local_db.dart';
import '../../init_dependency.dart';

class CurrentAppUser {
  final UserAuth userAuth;
  final UserPrv? userPrvDetails;
  final Store? currentStore;

  //static CurrentUser? instance;

  CurrentAppUser._({required this.userAuth, required this.userPrvDetails, required this.currentStore}){
    _init();
  }

  _init() async{
    
    await serviceLocator<OpenUserInfoLocalDb>().call(NoParams()).then((e) {
      final result = handleDartz(dataResult: e);
      if(result == null) {
        dekhao("OpenUserInfoLocalDb call is failed!");
      } else {
        dekhao("OpenUserInfoLocalDb call is successful.");
      }
    });
  }

  // static CurrentUser get instance {
  //   return instance ?? CurrentUser._(userAuth: userAuth, userPrvDetails: userPrvDetails, currentStore: currentStore)
  // }

  @override
  String toString() => 'CurrentAppUser(userAuth: ${userAuth.toString()}, userPrvDetails: ${userPrvDetails.toString()}, currentStore: ${currentStore.toString()})';

  @override
  bool operator ==(covariant CurrentAppUser other) {
    if (identical(this, other)) return true;
  
    return 
      other.userAuth == userAuth &&
      other.userPrvDetails == userPrvDetails &&
      other.currentStore == currentStore;
  }

  @override
  int get hashCode => userAuth.hashCode ^ userPrvDetails.hashCode ^ currentStore.hashCode;
}



class CurrentAppUserProvider extends ChangeNotifier{

  CurrentAppUser? currentAppUser;

  UserPrv? _currentUser;

  CurrentAppUserProvider();

  UserPrv? get currentUser => _currentUser;

  Future<UserPrv?> fetchCurrentUser({bool? forceFetch}) async{
    return await serviceLocator<FetchCurrentUserInfo>().call(forceFetch).then((value) {
      return value.fold((l) {
          Fluttertoast.showToast(msg: l.message);
          return null;
        }, (r) {
          _currentUser = r; notifyListeners();
          return r;
        });
    });
  }

  Future<CurrentAppUser> getCurrentAppUser(UserAuth userAuth, StoreDataProvider storeDataProvider ) async{

    return await fetchCurrentUser(forceFetch: true).then((userPrvDetails) async{
      if(userPrvDetails == null) {
        dekhao("userPrvDetails is null in CurrentAppUser");
        currentAppUser = CurrentAppUser._(userAuth: userAuth, userPrvDetails: userPrvDetails, currentStore: null);
        return currentAppUser!;
      }else {
        dekhao("userPrvDetails is not null in CurrentAppUser");
        return await storeDataProvider.fetchCurrentStore().then((currentStore) {
          currentAppUser = CurrentAppUser._(userAuth: userAuth, userPrvDetails: userPrvDetails, currentStore: currentStore);
          return currentAppUser!;
        });
      }

      
    });
  }


  Future<UserPub?> fetchUserInfo({required String userId}) async{
    return await serviceLocator<FetchUserInfo>().call(userId).then((value) {
      return value.fold((l) {
          Fluttertoast.showToast(msg: l.message);
          return null;
        }, (r) {
          return r;
        });
    });
  }

  
}