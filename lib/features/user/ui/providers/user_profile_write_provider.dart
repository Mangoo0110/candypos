


import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

import '../../../../core/common/enums/common_enums.dart';
import '../../../../core/common/notifiers/save_status_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/utils/func/dekhao.dart';
import '../../../../init_dependency.dart';
import '../../../auth/domain/entities/user_auth.dart';
import '../../../image/domain/usecases/save_image_with_reference_path.dart';
import '../../domain/entities/user_prv.dart';
import '../../domain/usecases/save_user_info.dart';

enum WriteType {creating, updating}

class UserProfileWriteProvider extends ChangeNotifier { 

  WriteType _writeType = WriteType.creating;

  final UserPrv? _oldUserInfo;

  late UserPrv _newUserInfo;

  Key _key = UniqueKey();

  late SaveStatusNotifier saveStatusNotifier;

  Uint8List? _newImage;

  UserProfileWriteProvider(this._oldUserInfo, UserAuth userAuth,){
    saveStatusNotifier = SaveStatusNotifier(_key);
    if(_oldUserInfo != null) {
      _newUserInfo = _oldUserInfo.copyWith();
      _writeType = WriteType.updating;
    } else {
      _writeType = WriteType.creating;
      _newUserInfo = UserPrv(
        id: userAuth.id, 
        email: userAuth.email, 
        fullName: '', 
        gender: null,
        birthdate: null,
        joinedAt: DateTime.now(), 
        imageUrl: null, 
        about: '', country: '', contactNo: '');
    }
  }

  void init(UserAuth userAuth) {
    if(_oldUserInfo != null) {
      _newUserInfo = _oldUserInfo;
      _writeType = WriteType.updating;
    } else {
      _writeType = WriteType.creating;
      _newUserInfo = UserPrv(
        id: userAuth.id, 
        email: userAuth.email, 
        fullName: '', 
        gender: null,
        birthdate: null,
        joinedAt: DateTime.now(), 
        imageUrl: null, 
        about: '', country: '', contactNo: '');
    }
  }

  //getters

  WriteType get writeType => _writeType;

  //SaveStatus get saveStatus => saveStatus;

  void checkIfCanSave(){
    if(_newImage != null || _newUserInfo != _oldUserInfo){
      dekhao("can save");
      if(saveStatusNotifier.saveStatus != SaveStatus.canSave){
        saveStatusNotifier.setSaveStatus(_key, SaveStatus.canSave);
      }
    }
  }

  void setEmail(String email){
    _newUserInfo.email = email.trim();
    checkIfCanSave();
  }

  void setFullName(String fullName){
    _newUserInfo.fullName = fullName.trim();
    dekhao(fullName);
    checkIfCanSave();
  }

  void setProfession(String about){
    _newUserInfo.about = about.trim();
    checkIfCanSave();
  }

  void setImage(Uint8List image){
    _newImage = image;
    checkIfCanSave();
  }

  void setGender(Gender gender){
    _newUserInfo.gender = gender;
    checkIfCanSave();
  }

  DateTime? setBirthdate(DateTime birthdate){
    _newUserInfo.birthdate = birthdate;
    checkIfCanSave();
    return birthdate;
  }

  Future<void> saveUser() async{

    if(saveStatusNotifier != SaveStatus.canSave) return;

    saveStatusNotifier.setSaveStatus(_key, SaveStatus.saving);

    // First save new store to the remote db.
    await _saveUserInfo().then((userPrv) async{

      // If store is saved successfully, then save the store image also.
      if(userPrv != null) {
        await _updateProfileImage(userPrv: userPrv).then((imageIsSaved) {
          // If success.
          if(imageIsSaved) {
            saveStatusNotifier.setSaveStatus(_key, SaveStatus.success);
          }
          // If failed.
          if(!imageIsSaved){
            saveStatusNotifier.setSaveStatus(_key, SaveStatus.failed);
          }

        });
      } else {
        saveStatusNotifier.setSaveStatus(_key, SaveStatus.failed);
      }
    });
  }


  Future<UserPrv?> _saveUserInfo() async{

    if(saveStatusNotifier == SaveStatus.canNotSave) {
      throw Exception("Can not save user info. First check if can save.");
    }

    await serviceLocator<SaveUserInfo>().call(_newUserInfo).then((value) {
      value.fold((l) {
        Fluttertoast.showToast(msg: "Could not save user info!. ${l.message}");
      }, (r) async{
        Fluttertoast.showToast(msg: "User info is saved.");
        return _newUserInfo;
      });
      
    });
  }



  Future<bool> _updateProfileImage({required UserPrv userPrv}) async{

    if(_newImage == null) return true;

    return await serviceLocator<SaveImageWithReferencePath>().call(
        SaveImageWithReferencePathParams(referencePath: userPrv.imageUrl, imageData: _newImage!)
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