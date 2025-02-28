import 'package:cloud_firestore/cloud_firestore.dart';

String uuidByFirebaseSdk(){
  return FirebaseFirestore.instance.collection('any').doc().id;
}