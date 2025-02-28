
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/utils/constants/data_field_key_names.dart';
import 'user_prv_model.dart';

/// **This is an offline-feature class.**
class UserSync{
  /// **'type'** is the type of document is present in the database at the moment. Means is the document is removed, added or modified.
  /// Right now we only care about the types removed, added. If a document is added or modified, we simply set its type status as added.
  
  final DocumentChangeType type;
  final UserPrvModel userPrv;
  final bool isSynced;

  UserSync({required this.type, required this.userPrv, required this.isSynced});

  factory UserSync.fromMap(Map<String, dynamic> map){
    return UserSync(
      type: map[kType] == null || map[kType] == DocumentChangeType.added.name ? DocumentChangeType.added
          : map[kType] == DocumentChangeType.removed.name ? DocumentChangeType.removed 
          : DocumentChangeType.added,
      userPrv: UserPrvModel.fromMap(map['userPrv']), 
      isSynced: map[kIsSynced] == null ? false : bool.tryParse(map[kIsSynced].toString()) ?? false
    );
  }

  Map<String, dynamic> toMap(){
    return {
      kType: type.name,
      "userPrv": userPrv.toMap(),
      kIsSynced: isSynced,
    };
  }
}