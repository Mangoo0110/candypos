

import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/utils/func/dekhao.dart';
import 'package:flutter/material.dart';
import '../../domain/repositories/image_repo.dart';

import '../../../../init_dependency.dart';
import '../../domain/usecases/fetch_image.dart';
import '../../domain/usecases/fetch_image_from_local_db.dart';

class ImageReadProvider extends ChangeNotifier{
  

  ImageReadProvider();

  Future<ImageX?> fetchImage({required Reference imageUrl, bool? forceFetch, bool fromLocalDb = false})async{
    
    dekhao("imageUrl is ${imageUrl.fullPath}");

    if(fromLocalDb) {
      return await serviceLocator<FetchImageFromLocalDb>().call(FetchImageFromLocalDbParams(url: imageUrl.fullPath)).then((value) {
        return value.fold(
          (l) {
            return null;
          }, (r) {
            return r;
          });
      });
    } else{
      return await serviceLocator<FetchImage>().call(FetchImageParams(storageRef: imageUrl, forceFetch: false)).then((value) {
          return value.fold(
            (l) {
              return null;
            }, (r) {
              return r;
            });
      });
    }
    
  }

}