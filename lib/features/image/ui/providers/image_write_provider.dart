
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';

// import '../../../../core/common/enums/common_enums.dart';
// import '../../../../core/utils/func/dekhao.dart';
// import '../../../../init_dependency.dart';
// import '../../domain/repositories/image_repo.dart';
// import '../../domain/usecases/fetch_image.dart';
// import '../../domain/usecases/fetch_image_from_local_db.dart';
// import '../../domain/usecases/save_image_with_reference_path.dart';

// class ImageWriteProvider extends ChangeNotifier{

//   Uint8List? _image;
//   Uint8List? _imageBefore;
//   Reference _referencePath;
//   SaveStatus _saveStatus = SaveStatus.canNotSave;

//   //getters
//   bool get canSave => _saveStatus != SaveStatus.canNotSave;

//   Uint8List? get image => _image;

//   Reference? get referencePath => _referencePath;

//   void checkIfCanSave(){
//     if(true){
//       if(_saveStatus == SaveStatus.canNotSave){
//         _saveStatus = SaveStatus.canNotSave; notifyListeners();
//       }
//     }
//   }

//   ImageWriteProvider();

//   void init({required String? referencePath, required Uint8List? image, bool fromLocalDb = false}) {

//     _saveStatus != SaveStatus.canNotSave; 
//     _imageBefore = image;
//     _image = image;

//     // if(fromLocalDb && referencePath != null){
//     //   dekhao("referencePath: $referencePath");
//     //   _referencePath = referencePath;
//     //   getImageFromLocalPath(referencePath);
//     // }

//     // if(fromLocalDb != true && referencePath != null){
//     //   _referencePath = referencePath;
//     //   getImageFromExistingUrl();
//     // }
    
//   }

//   Future<void> getImageFromLocalPath(String pathKey) async{
//     return await serviceLocator<FetchImageFromLocalDb>().call(FetchImageFromLocalDbParams(url: pathKey,)).then((value) {
//         return value.fold(
//           (l) {
//             return null;
//           }, (r) {
//             _imageBefore = r.image;
//             _image = r.image; notifyListeners();
//           });
//     });
//   }

//   Future<void> getImageFromExistingUrl() async{
//     if(_referencePath == null) return;
//     return await serviceLocator<FetchImage>().call(FetchImageParams(storageRef: _referencePath, forceFetch: false)).then((value) {
//         return value.fold(
//           (l) {
//             return null;
//           }, (r) {
//             dekhao("fetched existingImageUrl ...");
//             _image = r.image; notifyListeners();
//           });
//     });
//   }
  
//   void changeImage(Uint8List image){
//     _image = image;
//     _saveStatus = SaveStatus.canSave;
//     notifyListeners();
//   }


//   Future<ImageX?> saveImage() async{

//     if(_saveStatus == SaveStatus.canSave && _image != null && _referencePath != null){
//       dekhao("saving image.");
//       return await serviceLocator<SaveImageWithReferencePath>().call(SaveImageWithReferencePathParams(referencePath: _referencePath!, imageData: _image!)).then((lr){
//         return lr.fold (
//           (l) {
//             return null;
//           }, 
//           (r) {
//             _image = null;
//             _referencePath = null;
//             _saveStatus != SaveStatus.canNotSave;
//             return r;
//           }
//         );
//       });
//     }
//     return null;
//   }
// }