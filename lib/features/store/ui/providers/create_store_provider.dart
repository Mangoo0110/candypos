import 'dart:typed_data';

import 'package:candypos/core/utils/func/dekhao.dart';

import '../../../../core/common/enums/common_enums.dart';
import '../../../../core/utils/uuid_service/firebase_uid.dart';
import '../../../../core/common/notifiers/save_status_provider.dart';

import '../../../../init_dependency.dart';
import '../../../auth/domain/entities/user_auth.dart';
import '../../../image/domain/usecases/save_image_with_reference_path.dart';
import '../../domain/entities/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../domain/usecases/create_store.dart';

class CreateStoreProvider extends ChangeNotifier {

  final UserAuth _userAuth;

  String _storeName = '';

  String _address = '';

  String _contactNo = '';

  Uint8List? _storeImage;

  Key _key = UniqueKey();

  late SaveStatusNotifier saveStatusNotifier;

  CreateStoreProvider(this._userAuth){
    saveStatusNotifier = SaveStatusNotifier(_key);
  }

  // getters
  Uint8List? get storeImage => _storeImage;
  String? get storeName => _storeName;
  String? get address => _address;
  String? get contactNo => _contactNo;


  void _checkIfCanSave() {
    if(_storeName.isNotEmpty && _address.isNotEmpty && _contactNo.isNotEmpty) {
      if(saveStatusNotifier.saveStatus != SaveStatus.canSave) saveStatusNotifier.setSaveStatus(_key, SaveStatus.canSave); 
    } else {
      if(saveStatusNotifier.saveStatus != SaveStatus.canNotSave) saveStatusNotifier.setSaveStatus(_key, SaveStatus.canNotSave); 
    }
  }


  void setStoreName(String name) {
    _storeName = name;
    _checkIfCanSave();
  }

  void setAddress(String address) {
    _address = address;
    _checkIfCanSave();
  }

  void setContactNo(String contactNo) {
    _contactNo = contactNo;
    _checkIfCanSave();
  }

  void setNewStoreImage(Uint8List image) {
    _storeImage = image;
    _checkIfCanSave();
  }


   Future<void> createStore() async{

    saveStatusNotifier.setSaveStatus(_key, SaveStatus.saving);

    // return Future.delayed(Duration(milliseconds: 900)).then((_) {
    //   saveStatusNotifier.setSaveStatus(_key, SaveStatus.failed);
    //   return Future.delayed(Duration(milliseconds: 900)).then((_) {
    //     saveStatusNotifier.setSaveStatus(_key, SaveStatus.canSave);
    //     return ;
    //   }); 
    // }); 

    // First save new store to the remote db.
    await _createStore().then((store) async{

      // If store is saved successfully, then save the store image also.
      if(store != null) {
        await _addStoreImage(createdStore: store).then((imageIsSaved) {
          // If success.
          if(imageIsSaved) {
            saveStatusNotifier.setSaveStatus(_key, SaveStatus.success); 
          }
          // If failed.
          if(!imageIsSaved){
            dekhao("Image saving is failed while creating new store");
            saveStatusNotifier.setSaveStatus(_key, SaveStatus.failed); 
          }

        });
      } else {
        dekhao("Encountered error while creating new store");
        saveStatusNotifier.setSaveStatus(_key, SaveStatus.failed); 
      }
    });
  }

  Future<Store?> _createStore() async{

    // if(saveStatusNotifier.saveStatus != SaveStatus.canSave) {
    //   dekhao("Store can not be saved!!");
    //   return null;
    // }

    try {
      final store = Store(
        id: uuidByFirebaseSdk(), 
        franchise: null, 
        imageUrl: null, 
        storeName: _storeName,
        contactNo: _contactNo, 
        address: _address, 
        createdAt: DateTime.now(), 
        createdBy: _userAuth.id,
      );

      dekhao("New store to be create is:: ${store.toString()}");

      return await serviceLocator<CreateStore>().call(store).then((value) async{
          return value.fold(
            (l) {
              dekhao("Failed! Could not save the store info.");
              Fluttertoast.showToast(msg: "Failed! Could not save the store info.");
              return null;
            }, 
            (r) async{
              Fluttertoast.showToast(msg: "Done! Store info is updated.");
              return store;
            });
        
      });
    } catch (e) {
      dekhao(e);
      return null;
    }

    
    
  }

  Future<bool> _addStoreImage({required Store createdStore}) async{

    if(_storeImage == null) return true;

    return await serviceLocator<SaveImageWithReferencePath>().call(
        SaveImageWithReferencePathParams(referencePath: createdStore.imageUrl, imageData: _storeImage!)
      ).then((value) async{
        return value.fold(
          (l) {
            Fluttertoast.showToast(msg: "Failed! Could not save the store info.");
            return false;
          }, 
          (r) async{
            Fluttertoast.showToast(msg: "Done! Store info is updated.");
            return true;
          });
      
    });
    
  }


}