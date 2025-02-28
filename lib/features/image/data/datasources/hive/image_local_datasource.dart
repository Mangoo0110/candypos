import 'dart:collection';
import 'dart:typed_data';

import 'package:hive/hive.dart';

import '../../../../../core/utils/func/dekhao.dart';
import '../../../domain/repositories/image_repo.dart';

abstract interface class ImageLocalDatasource{
  Future<ImageLocal> fetchImage({required String imageUrl, bool? forceFetch});

  // Future<String> saveImageWithUrl({required String existingImageUrl, required Uint8List image});

  Future<ImageLocal> saveImage({required String referencePath, required Uint8List image});

  Future<void> deleteImage({required String imageUrl});
}

class ImageHiveDatasouceImpl implements ImageLocalDatasource {


  ImageHiveDatasouceImpl._(){
    if(_box == null){
      openBox();
    }
  }

  final SplayTreeMap<String, Uint8List> _images = SplayTreeMap<String, Uint8List>();

  static ImageHiveDatasouceImpl? _instance;
  Box<dynamic>? _box;
  int _boxModifiedCnt = 0;


  static ImageHiveDatasouceImpl get instance {
    _instance ??= ImageHiveDatasouceImpl._();
    return _instance!;
  }

  final _boxName = 'ImageBox';

  Future<bool> openBox() async{
    dekhao("opening image box");
    try {
      _box ??= await Hive.openBox(_boxName);
      if(_box == null) {
        dekhao("_box is still null");
        return false;
      } else {
        dekhao("_box is not null and functionable ${_box?.name}");
        return true;
      }
    } catch (e) {
      dekhao("Failed to open box.. $e");
      rethrow;
    }
  }

  @override
  Future<void> deleteImage({required String imageUrl}) async{
    return await openBox().then((_) async{
      return await _box!.delete(imageUrl);
    });
  }

  @override
  Future<ImageLocal> fetchImage({required String imageUrl, bool? forceFetch}) async{
    return await openBox().then((_) async{
      return ImageLocal._(url: imageUrl, image: _box!.get(imageUrl));
    });
  }

  @override
  Future<ImageLocal> saveImage({required String referencePath, required Uint8List image}) async{
    return await openBox().then((_) async{
      return await _box!.put(referencePath, image).then((value) => ImageLocal._(url: referencePath, image: image));
    });
  }

  // @override
  // Future<String> saveImageWithUrl({required String existingImageUrl, required Uint8List image}) async{
  //   // TODO: implement saveImageWithUrl
  //   throw UnimplementedError();
  // }

}



class ImageLocal extends ImageX {
  

  ImageLocal._({required super.url, required super.image,}): super(fromLocalDb: true);


  @override
  bool operator ==(covariant ImageLocal other) {
    if (identical(this, other)) return true;
  
    return 
      other.url == url &&
      other.fetchedAt == fetchedAt &&
      other.image == image;
  }

  @override
  int get hashCode => url.hashCode ^ fetchedAt.hashCode ^ image.hashCode;
}
