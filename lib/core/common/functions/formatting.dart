import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

DateTime? parseDateTime(dynamic dateData) {
  return dateData == null ? DateTime.now() 
    : dateData.runtimeType == Timestamp 
    ? (dateData as Timestamp).toDate() 
    : dateData.runtimeType == int 
    ? DateTime.fromMillisecondsSinceEpoch(dateData)
    : dateData.runtimeType == String
    ? DateTime.parse(dateData)
    : null;
}


extension on FirebaseStorage {}

Reference? parseStorageReference(String urlOrPath) {
  try {
    return FirebaseStorage.instance.refFromURL(urlOrPath);
  } catch (e) {
    try {
      return FirebaseStorage.instance.ref(urlOrPath);
    } catch (e) {
      
      return null;
    }
  }
}
