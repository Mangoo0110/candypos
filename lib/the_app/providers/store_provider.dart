
// import 'package:candypos/features/store/domain/usecases/fetch_all_stores_of_user.dart';
// import 'package:flutter/foundation.dart';

// import 'core/usecases/usecases.dart';
// import 'core/utils/func/dekhao.dart';
// import 'features/store/domain/entities/store.dart';
// import 'features/store/domain/usecases/fetch_store.dart';
// import 'init_dependency.dart';

// class StoreProvider extends ChangeNotifier {
//   Store? _currentStore;

//   Store? get currentStore => _currentStore;

//   StoreProvider() {
//     dekhao("store provider registering");
//     fetchCurrentStore();
//   }

//   Future<Store?> fetchCurrentStore() async{
//     if(_currentStore != null) return _currentStore;
//     return await serviceLocator<FetchCurrentStore>().call(NoParams()).then((value) {
//       return value.fold(
//         (l) {
//           return null;
//         }, 
//         (r) {
//         _currentStore = r;
//         notifyListeners();
//         return r;
//       });
//     });
//   }


  
//   Future<void> updateUserImage({required Uint8List image, required String imageId}) async{
    
//   }


  
// }
