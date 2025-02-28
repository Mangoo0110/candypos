import 'package:candypos/features/image/domain/usecases/save_image_with_reference_path.dart';
import 'package:candypos/features/store/domain/usecases/update_store_info.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/foundation.dart';

import '../../../../core/common/enums/common_enums.dart';
import '../../../../init_dependency.dart';
import '../../domain/entities/store.dart';

class ModifyStoreProvider extends ChangeNotifier{
  SaveStatus _saveStatus = SaveStatus.canNotSave;
  final Store _modifyingStore;

  Uint8List? _newStoreImage;
  String? _modifiedStoreName;
  String? _modifiedAddress;
  String? _modifiedContactNo;
  String? _modifiedImageUrl;

  ModifyStoreProvider({required Store modifyingStore}) : _modifyingStore = modifyingStore;

  // getters
  SaveStatus get saveStatus => _saveStatus;
  Uint8List? get newStoreImage => _newStoreImage;
  String? get modifiedStoreName => _modifiedStoreName;
  String? get modifiedAddress => _modifiedAddress;
  String? get modifiedContactNo => _modifiedContactNo;
  String? get modifiedImageUrl => _modifiedImageUrl;
  Store get modifyingStore => _modifyingStore;


  void _checkIfCanSave() {
    if(_modifiedStoreName != null || _modifiedAddress != null || _modifiedContactNo != null || _newStoreImage != null) {
      if(_saveStatus != SaveStatus.canSave) _saveStatus = SaveStatus.canSave; notifyListeners();
    } else {
      if(_saveStatus != SaveStatus.canNotSave) _saveStatus = SaveStatus.canNotSave; notifyListeners();
    }
  }


  void setModifiedStoreName(String name) {
    _modifiedStoreName = name;
    _checkIfCanSave();
  }

  void setModifiedAddress(String address) {
    _modifiedAddress = address;
    _checkIfCanSave();
  }

  void setModifiedContactNo(String contactNo) {
    _modifiedContactNo = contactNo;
    _checkIfCanSave();
  }

  void setNewStoreImage(Uint8List image) {
    _newStoreImage = image;
    _checkIfCanSave();
  }


   Future<void> updateStore({required VoidCallback ondone}) async{

    _saveStatus = SaveStatus.saving; notifyListeners();

    if(_newStoreImage != null) {
      await _updateStoreImage(newImage: _newStoreImage!).then((imageIsSaved) async{
        if(imageIsSaved) {
          await _updateStoreInfo().then((infoIsSaved) {
            if(infoIsSaved) {
              _saveStatus = SaveStatus.success; notifyListeners();
            } else{
              _saveStatus = SaveStatus.failed; notifyListeners();
            }
          });
      
        }
        });
    }


    return await serviceLocator<UpdateStoreInfo>().call(
      UpdateStoreInfoParams(
        storeId: _modifyingStore.id, 
        storeName: _modifiedStoreName, 
        imageUrl: _modifiedImageUrl, 
        address: _modifiedAddress, 
        contactNo: _modifiedContactNo,
      )).then((value) async{
        return value.fold(
          (l) {
            Fluttertoast.showToast(msg: "Failed! Could not save the branch info.");
            Fluttertoast.showToast(msg: "${l.message}, ${l.failure.name}");
          }, 
          (r) async{
            Fluttertoast.showToast(msg: "Branch info saved.");
            
          });
      
    });
    
  }

  Future<bool> _updateStoreInfo() async{


    return await serviceLocator<UpdateStoreInfo>().call(
      UpdateStoreInfoParams(
        storeId: _modifyingStore.id, 
        storeName: _modifiedStoreName, 
        imageUrl: _modifiedImageUrl, 
        address: _modifiedAddress, 
        contactNo: _modifiedContactNo,
      )).then((value) async{
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

  Future<bool> _updateStoreImage({required Uint8List newImage}) async{


    return await serviceLocator<SaveImageWithReferencePath>().call(
        SaveImageWithReferencePathParams(referencePath: _modifyingStore.imageUrl, imageData: newImage)
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

