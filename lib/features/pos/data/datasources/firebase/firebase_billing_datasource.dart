// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dartz/dartz.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import '../../models/bill_model.dart';
// import '../../models/enums_of_models.dart';

// abstract interface class RemoteBillingDataSource{

//   Future<void> saveBill({required BillModel billModel});

//   Future<void> deleteBill({required String billId});

//   Future<>
// }


// class FirebaseBillingRepoImpl extends RemoteBillRepo {

//   final String _userId;
//   final String _storeId;
//   late CollectionReference<Map<String, dynamic>> _billingCollectionReference ;
  
//   FirebaseBillingRepoImpl({
//     required String userId, 
//     required String storeId
//     }): _userId = userId,
//         _storeId = storeId {
//           _billingCollectionReference = FirebaseFirestore.instance.collection(kfirestoreUserCollection)
//           .doc(userId).collection(kfirestoreStoreCollection)
//           .doc(storeId).collection(kFirestoreBillingCollection);
//       }

//   @override
//   String newBillId() {
//     return FirebaseFirestore.instance.collection(kfirestoreUserCollection).doc(_userId).
//     collection(kfirestoreStoreCollection).doc(_storeId).
//     collection('$kfirestoreUserCollection/{$_userId}/$kfirestoreStoreCollection/{$_storeId}/$kFirestoreBillingCollection').doc().id;
//   }

//   @override
//   Future<Either<DataCRUDFailure, Success>> deleteBill({required String billId}) async{
//     try {

//       await _billingCollectionReference.doc(billId).delete();
//       return Right(Success(message: 'Bill is deleted.'));

//     } on SocketException {
//       return Left(DataCRUDFailure(failure: Failure.socketFailure, message: 'Internet connection failed!'));
//     } on FirebaseAuthException catch(e){
//       return Left(DataCRUDFailure(failure: Failure.authFailure, message: e.toString()));
//     } catch (e) {
//       dekhao("remote error");
//       dekhao(e.toString());
//       return Left(DataCRUDFailure(failure: Failure.unknownFailure, message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<DataCRUDFailure, Success>> uploadBill({required BillModel bill}) async{
//     try {
//       WriteBatch batch = FirebaseFirestore.instance.batch();
//       batch.set(_billingCollectionReference.doc(bill.billId), bill.toMap());

//       return await batch.commit().then((value) {
//         return Right(Success(message: 'Bill is uploaded.'));
//       });

//     } on SocketException {
//       return Left(DataCRUDFailure(failure: Failure.socketFailure, message: 'Internet connection failed!'));
//     } on FirebaseAuthException catch(e){
//       return Left(DataCRUDFailure(failure: Failure.authFailure, message: e.toString()));
//     } catch (e) {
//       dekhao("remote error");
//       dekhao(e.toString());
//       return Left(DataCRUDFailure(failure: Failure.unknownFailure, message: e.toString()));
//     }
//   }

//   @override
//   Either<DataCRUDFailure, Stream<List<BillModel>>> fetchBillListInTimeRange({
//     required Timestamp fromTime, required Timestamp toTime
//   }) {
//     try {
//       // dekhao("fromTime:: ${DateFormat.yMMMd().format(fromTime.toDate())}, ${DateFormat.jms().format(fromTime.toDate())} ||  toTime:: ${DateFormat.yMMMd().format(toTime.toDate())}, ${DateFormat.jms().format(toTime.toDate())}");
//       return Right(_billingCollectionReference
//       .where(kbilledAt, isGreaterThanOrEqualTo: fromTime)
//       .where(kbilledAt, isLessThanOrEqualTo: toTime)
//       .where(kbillingStatus, isNotEqualTo: BillingStatus.onHold.name)
//       //.orderBy(kbilledAt)
//       .snapshots().map((querySnapshot) {
//         return querySnapshot.docChanges
//             .map((qDocSnap) {
//               dekhao(qDocSnap.doc.data().toString());
              
//               BillModel bill = BillModel.fromMap(map: qDocSnap.doc.data()!);
//               // dekhao(product.toMap());
//               return bill;
//             })
//             .toList();
//       }));

//     } on SocketException {
//       return Left(DataCRUDFailure(failure: Failure.socketFailure, message: 'Internet connection failed!'));
//     } on FirebaseAuthException catch(e){
//       return Left(DataCRUDFailure(failure: Failure.authFailure, message: e.toString()));
//     } catch (e) {
//       dekhao("remote error");
//       dekhao(e.toString());
//       return Left(DataCRUDFailure(failure: Failure.unknownFailure, message: e.toString()));
//     }
//   }
  
//   @override
//   Future<Either<DataCRUDFailure, List<BillModel>>> fetchBillListOfCustomerByContactNoInTimeRange({required String contactNo, required Timestamp fromTime, required Timestamp toTime}) async{
//     try {

//       return Right(await _billingCollectionReference
//       .where(kcustomerContactNo, isEqualTo: contactNo)
//       .where(kbilledAt, isLessThanOrEqualTo: toTime, isGreaterThanOrEqualTo: fromTime)
//       .get().then((querySnapshot) {
//         return querySnapshot.docs
//             .map((qsnap) {
//               // dekhao(qsnap.data().toString());
//               BillModel product = BillModel.fromMap(map: qsnap.data());
//               // dekhao(product.toMap());
//               return product;
//             })
//             .toList();
//       }));

//     } on SocketException {
//       return Left(DataCRUDFailure(failure: Failure.socketFailure, message: 'Internet connection failed!'));
//     } on FirebaseAuthException catch(e){
//       return Left(DataCRUDFailure(failure: Failure.authFailure, message: e.code));
//     } catch (e) {
//       dekhao("remote error");
//       dekhao(e.toString());
//       return Left(DataCRUDFailure(failure: Failure.unknownFailure, message: e.toString())); 
//     }
//   }
  
//   @override
//   Future<Either<DataCRUDFailure, List<BillModel>>> fetchBillListOfCustomerByNameInTimeRange({required String customerName, required Timestamp fromTime, required Timestamp toTime}) async{
//     try {

//       return Right(await _billingCollectionReference
//       .where(kcustomerName, isEqualTo: customerName)
//       .where(kbilledAt, isLessThanOrEqualTo: toTime, isGreaterThanOrEqualTo: fromTime)
//       .get().then((querySnapshot) {
//         return querySnapshot.docs
//             .map((qsnap) {
//               // dekhao(qsnap.data().toString());
//               BillModel product = BillModel.fromMap(map: qsnap.data());
//               // dekhao(product.toMap());
//               return product;
//             })
//             .toList();
//       }));

//     } on SocketException {
//       return Left(DataCRUDFailure(failure: Failure.socketFailure, message: 'Internet connection failed!'));
//     } on FirebaseAuthException catch(e){
//       return Left(DataCRUDFailure(failure: Failure.authFailure, message: e.code));
//     } catch (e) {
//       dekhao("remote error");
//       dekhao(e.toString());
//       return Left(DataCRUDFailure(failure: Failure.unknownFailure, message: e.toString())); 
//     }
//   }
  

// }